class Comment < ApplicationRecord
  belongs_to :user 
  belongs_to :song

  validates :content, presence: true, length:{minimum:6 ,maximum:1000}
  validates :user_id, presence: true
  validates :song_id, presence: true
end
