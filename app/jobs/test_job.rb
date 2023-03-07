class TestJob
  include Sidekiq::Worker

  def perform(str)
    Rails.logger.info ''
    Rails.logger.info '*' * 80

    Rails.logger.info "SideKiq TestJob: #{str}"
    RedisHelper.set "testjob", str

    Rails.logger.info '*' * 80
    Rails.logger.info ''
  end
end
