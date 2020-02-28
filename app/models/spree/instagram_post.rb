module Spree
  class InstagramPost < Spree::Base
    belongs_to :product
    belongs_to :instagram_user
    scope :user, -> { where(hashtag_id: nil) }
    scope :hashtag, -> { where.not(hashtag_id: nil) }
    has_one_attached :media
    has_one_attached :profile_picture_media
  end
end
