class InvitedUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :story, class_name: "Nik"

  validates :story_id, presence: true
end
