module Spree
  class InstagramPost < Spree::Base
    belongs_to :product
    scope :user, -> { where(hashtag_id: nil) }
    scope :hashtag, -> { where.not(hashtag_id: nil) }
  end
end
