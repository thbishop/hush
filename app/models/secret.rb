class Secret
  include ActiveModel::Model
  extend ActiveModel::Callbacks
  include ActiveModel::Validations

  attr_accessor :data, :id

  validates :data, :presence => true

  def self.find(id)
    data = REDIS.get id
    return nil unless data

    Secret.new :data => data, :id => id
  end

  def decrypted_data
    REDIS.del id
    decrypt_data @data
  end

  def id
    @id ||= generate_id
  end

  def save
    return false unless valid?

    operation = REDIS.setex id, 600, encrypt_data(data)
    operation == 'OK'
  end

  def to_param
    id
  end

  private
  def encrypt_data(data)
    Encryptor.encrypt data, :key => HUSH_ENCRYPTION_KEY
  end

  def decrypt_data(encrypted_data)
    Encryptor.decrypt encrypted_data, :key => HUSH_ENCRYPTION_KEY
  end

  def generate_id
    SecureRandom.urlsafe_base64(40)
  end

end
