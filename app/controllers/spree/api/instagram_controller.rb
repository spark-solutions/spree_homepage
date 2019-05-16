module Spree
  module Api
    class InstagramController < Spree::Api::V2::BaseController
      def feed
        posts = Spree::InstagramPost.where(show: true).map(&:data).map { |post| JSON.parse post }
        render_serialized_payload { posts }
      end
    end
  end
end
