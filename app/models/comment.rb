class Comment < ApplicationRecord
  belongs_to :user 
  belongs_to :song
  after_destroy :reduce_reply
  scope :base_comment,  ->{where parent_id: nil}
  scope :comment_by_id , ->id{where("song_id = ?" , id)}
  scope :get_reply , ->id{where("parent_id = ?" , id)}
  validates :content, presence: true, length:{minimum:6 ,maximum:1000}
  validates :user_id, presence: true
  validates :song_id, presence: true

  private 

    def reduce_reply
      if !self.parent_id.nil?
        @parent = Comment.find_by(id: self.parent_id)
        count = @parent.reply - 1
        @parent.update_attribute(:reply , count)
      end
    end

end
