class Nik < ActiveRecord::Base
  has_ltree_hierarchy

  belongs_to :user

  class << self
    def without_root
      where("parent_id IS NOT NULL")
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

  def root
    ancestors.find_by(parent_id: nil)
  end

  def first_branch
    last_leaves.first.try(:self_and_ancestors) || self_and_ancestors
  end

  def first_branch_without_root
    first_branch.without_root
  end
end
