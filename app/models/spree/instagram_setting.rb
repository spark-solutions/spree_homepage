class Spree::InstagramSetting < Spree::Base
  has_many :instagram_posts, dependent: :destroy
  before_save :set_hashtag_id

  def self.access_token
    first_or_create.access_token
  end

  def self.hashtag_id
    first_or_create.hashtag_id
  end

  def self.code
    first_or_create.code
  end

  def self.user_id=(user_id)
    first_or_create.update(user_id: user_id)
  end

  def self.access_token=(access_token)
    first_or_create.update(access_token: access_token)
  end

  def self.hashtag_id=(hashtag)
    first_or_create.update(hashtag: hashtag)
  end

  private

  def set_hashtag_id
    hashtag_id = Instagram::GetHashtagId.new(self, hashtag).call
  end
end
