class CommentBlueprint < Blueprinter::Base
  identifier :id
  field :content
  field :reply
  field :name do |comment|
    "#{comment.user.name}"
  end
  field :image do |comment|
    "#{comment.user.avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_url(comment.user.avatar, only_path: true) : ""}"
  end
end