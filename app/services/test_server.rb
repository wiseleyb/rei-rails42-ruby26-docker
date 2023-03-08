# Dummy server for testing customer servers in docker
class TestServer
  def self.run!
    loop do
      puts ''
      puts '*' * 15
      puts "ts: #{Time.now.to_f}"
      puts '*' * 15
      puts ''
      sleep 10
    end
  end
end
