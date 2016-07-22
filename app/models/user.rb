# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  username               :string           default(""), not null
#  name                   :string
#  last_name              :string
#  bio                    :text
#  uid                    :string
#  provider               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  
  validates :username, presence: true, uniqueness: true, length: {in: 3..12}
  #validates :username, presence: true, uniqueness: true, length: {minimum: 3,maximum: 12}
  validate :validate_username_regex

  def self.from_omniauth(auth)
  	where(provider: auth[:provider], uid: auth[:uid] ).first_or_create do |user|
  		if auth[:info]
  			user.email = auth[:info][:email]
  			user.name = auth[:info][:name]
        user.provider = auth[:provider]
        user.uid = auth[:uid]
  		end
  		user.password = Devise.friendly_token[0,20]
  	end
  end

  private
  def validate_username_regex
    unless username = ~/\A[a-zA-Z]*[a-zA-Z][a-zA-Z0-9_]*\z/
      errors.add(:username, "El username debe iniciar con una letra")
      errors.add(:username, "El username sólo puede contener _, letras")
    end
  end
end
