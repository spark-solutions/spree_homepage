module Spree
  class InstagramUser < Spree::Base
    has_many :instagram_posts
    has_one :image, as: :viewable, dependent: :destroy, class_name: 'Spree::InstagramUserImage'
  end
end
