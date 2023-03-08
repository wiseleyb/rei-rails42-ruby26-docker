# Dummy server for testing customer servers in docker
class TestServer
  def self.run!
    loop do
      puts ''
      puts '*' * 20
      puts "ts: #{Time.now.to_f}"
      puts '*' * 20
      puts ''
      sleep 5
    end
  end
end
