class Post < ApplicationRecord
  has_rich_text :body

  after_create :publish_after_3_mins

  def publish
    update(is_published: true)
  end


  private

  def publish_after_3_mins
    PublishPostJob.perform_later(id)
  end
end
