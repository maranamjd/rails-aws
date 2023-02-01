require "test_helper"

class PostMailerTest < ActionMailer::TestCase
  test "post_published_notification" do
    mail = PostMailer.post_published_notification
    assert_equal "Post published notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
