if ENV['HUSH_REDIS_URL']
  uri = URI.parse ENV['HUSH_REDIS_URL']

  args = Hash.new.tap do |h|
    %w(host password port).each do |item|
      h[item.to_sym] = uri.send item.to_sym unless uri.send(item.to_sym).blank?
    end
  end
else
  args = { :host => 'localhost', :port => '6379'}
end

REDIS = Redis.new args
