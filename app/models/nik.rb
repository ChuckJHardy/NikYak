class Nik < ActiveRecord::Base
  has_ltree_hierarchy

  belongs_to :user
  has_many :weights, class_name: "BranchWeight", foreign_key: :story_id
  has_one :last_leave_attached_weight,
    class_name: "BranchWeight",
    foreign_key: :path,
    primary_key: :path


  after_commit :recalculate_branch_weight, if: lambda { |record|
    record.previous_changes.include?(:votes) &&
    record.previous_changes[:votes].first != record.previous_changes[:votes].last
  }

  class << self
    def without_root
      where("parent_id IS NOT NULL")
    end

    # returns last leafs in the branches sorted by weight descending
    def top_stories
      with(last_leaves: select("niks.id").
        joins("LEFT JOIN niks AS niks2 ON niks.path @> niks2.path AND niks.path != niks2.path").
        where("niks.parent_id IS NOT NULL").
        group("niks.id").
        having("COUNT(niks2.id) = 0").
        order("niks.path")
      ).joins("JOIN last_leaves AS ll ON niks.id = ll.id").
        joins(:last_leave_attached_weight).
        order("branch_weights.weight DESC")
    end

    def roots_without_replies
      with(
        filtered_roots: roots.
          select("niks.id").
          joins("LEFT JOIN niks AS niks2 ON niks.id = niks2.parent_id").
          having("COUNT(niks2.id) = 0").
          group("niks.id")
      ).joins("JOIN filtered_roots AS fr ON niks.id = fr.id")
    end
  end

  def last_leaves_ids
    Nik.
      select("niks.id").
      joins("LEFT JOIN niks AS niks2 ON niks.path @> niks2.path AND niks.path != niks2.path").
      where("niks.path <@ ? AND niks.id != ?", path, id).
      group("niks.id").
      having("COUNT(niks2.id) = 0").
      order("niks.path")
  end

  def last_leaves
    Nik.
      with(last_leaves_ids: last_leaves_ids).
      joins("JOIN last_leaves_ids AS lli ON niks.id = lli.id")
  end

  def self_and_ancestors_sorted
    self_and_ancestors.order("niks.path")
  end

  def root
    ancestors.find_by(parent_id: nil)
  end

  def first_branch
    last_leaves.first.try(:self_and_ancestors_sorted) || self_and_ancestors_sorted
  end

  def first_branch_without_root
    first_branch.without_root
  end

  private
  def recalculate_branch_weight
    RecalculateBranchesWorker.perform_async(id)
  end
end
