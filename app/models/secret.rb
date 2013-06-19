class Secret
  include ActiveModel::Model
  extend ActiveModel::Callbacks
  include ActiveModel::Validations

  attr_accessor :data

  validates :data, :presence => true

  def save
    return false unless valid?

    operation = REDIS.setex id, 600, data
    operation == 'OK'
  end

  private
  def generate_id
    SecureRandom.urlsafe_base64(40)
  end

  def id
    @id ||= generate_id
  end

end
