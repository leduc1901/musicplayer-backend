class DownloadSongWorker
  include Sidekiq::Worker

  def perform(*args)
    puts "download"
    @users = User.all
    @users.update_all(downloads: 0)
  end
end
