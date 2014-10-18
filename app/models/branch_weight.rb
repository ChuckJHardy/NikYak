class BranchWeight < ActiveRecord::Base
  belongs_to :story, class_name: "Nik"

  validates :story_id, :path, presence: true
end
