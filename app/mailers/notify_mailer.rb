class NotifyMailer < ActionMailer::Base
  default from: "nikyak@insert.coffee",
    to: ["chuckjhardy@gmail.com", "chanhthedj@gmail.com", "jekabsons.edgars@gmail.com"]

  def nik_added_email(nik)
    @nik = nik

    mail(
      subject: 'New Nik'
    )
  end
end
