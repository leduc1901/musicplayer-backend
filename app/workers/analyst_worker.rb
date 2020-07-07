class AnalystWorker
  include Sidekiq::Worker

  def perform ()
    puts "Send email"
    UserMailer.analysis.deliver_now
  end
end
