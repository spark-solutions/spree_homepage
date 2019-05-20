module Spree
  module V2
    module Storefront
      class InstagramPostSerializer < BaseSerializer
        set_type :instagram_post
        attribute :data do |post|
          JSON.parse(post.data)
        end
      end
    end
  end
end
