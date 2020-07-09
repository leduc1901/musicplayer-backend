class UserMailer < ApplicationMailer
  default from: "letrongcuong75@gmail.com"
  def send_email(user , listener)
    @user = user
    @listener = listener
    mail to: @user.email, subject: "Your playlist is being enjoyed !"
  end

  def analysis
    @users = User.all
    @playlists = Playlist.all
    mail to: 'letrongduc1999@gmail.com' , subject: "Music Player Analyst"
  end

end
