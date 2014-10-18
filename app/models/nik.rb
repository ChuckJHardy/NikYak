class Nik < ActiveRecord::Base
  has_ltree_hierarchy

  belongs_to :user
end
