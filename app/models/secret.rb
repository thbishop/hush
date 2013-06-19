class Secret
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :data

  validates :data, :presence => true

  private
  def generate_id
    SecureRandom.urlsafe_base64(40)
  end

end
