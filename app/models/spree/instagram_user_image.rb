module Spree
  class InstagramUserImage < Asset
    include Configuration::ActiveStorage
    include Rails.application.routes.url_helpers

    def image_url(base_url)
      polymorphic_url(attachment.variant(resize: "1080x1080>"), host: base_url)
    end
  end
end
