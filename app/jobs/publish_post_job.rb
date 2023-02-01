class PublishPostJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find_by(id: post_id)
    post.publish

    PostMailer.with(post: post)
              .post_published_notification
              .deliver_later
  end
end
