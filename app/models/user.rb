class User < ApplicationRecord
  validates_presence_of :email, :name
  validates_uniqueness_of :email
  has_many :viewing_parties

  has_secure_password

  enum role: %w[default admin]

  def self.default_users
    User.where(role: 'default')
  end
end
