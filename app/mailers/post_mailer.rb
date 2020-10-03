class PostMailer < ApplicationMailer
  default from: 'from@example.com'
  layout 'mailer'

  def post_mail(blog)
    @blog = blog
    mail to: "@blog.user.email", subject: "投稿の確認メール"
  end

end
