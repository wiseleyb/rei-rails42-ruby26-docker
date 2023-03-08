desc 'Test Server rake job'
namespace :test_server do
  task run: :environment do
    TestServer.run!
  end
end
