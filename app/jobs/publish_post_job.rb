class PublishPostJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    sleep 180
    post = Post.find_by(id: post_id).publish
  end
end
