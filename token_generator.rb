require 'securerandom'

class TokenGenerator
  def self.generate(email)
    token = SecureRandom.hex(16)
    $redis.set(token, email)
    token
  end
end
