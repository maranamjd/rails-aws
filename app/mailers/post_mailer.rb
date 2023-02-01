class PostMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.post_published_notification.subject
  #
  def post_published_notification
    @post = params[:post]

    mail to: @post.user_email, subject: "Yay! your post was published!"
  end
end
