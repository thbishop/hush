class Secret
  include ActiveModel::Validations

  attr_accessor :data

  validates :data, :presence => true
end
