class Nik < ActiveRecord::Base
  has_ltree_hierarchy

  belongs_to :user
  has_many :yaks

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
end
