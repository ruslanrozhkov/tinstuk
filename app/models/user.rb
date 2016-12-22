class User < ApplicationRecord

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy

  has_attached_file :avatar,
                    :storage => :s3,
                    :style => { :medium => '370x370', :thumb => '100x100' }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  default_scope {order('id DESC')}

  def self.sign_in_from_facebook(auth)
    find_by(provider: auth['provider'], uid: auth['uid']) || create_user_from_facebook(auth)
  end

  def self.create_user_from_facebook(auth)
    create(
        avatar: process_uri(auth['info']['image'] + '?width=9999'),
        email: auth['info']['email'],
        provider: auth['provider'],
        uid: auth['uid'],
        name: auth['info']['name'],
        gender: auth['extra']['raw_info']['gender'],
        date_of_birth: auth['extra']['raw_info']['birthday'].present? ? Date.strptime( auth['extra']['raw_info']['birthday'], '%m/%d/%Y') : nil,
        location: auth['info']['location'],
        bio: auth['extra']['raw_info']['bio']
    )
  end

  private

  def self.process_uri(uri)
    avatar_url = URI.parse(uri)
    avatar_url.scheme = 'https'
    avatar_url .to_s
  end
end
