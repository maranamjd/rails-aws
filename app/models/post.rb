class Post < ApplicationRecord
  has_rich_text :body
  belongs_to :user

  after_create :publish_after_1_min
  delegate :email, to: :user, prefix: true

  def publish
    update(is_published: true)
  end

  private

  def publish_after_1_min
    PublishPostJob.set(wait: 1.minute).perform_later(id)
  end
end
