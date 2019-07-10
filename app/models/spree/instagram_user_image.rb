module Spree
  class InstagramUserImage < Asset
    include Configuration::ActiveStorage
    include Rails.application.routes.url_helpers

    def image_url(base_url)
      polymorphic_url(attachment.variant(resize: "1080x1080>"), host: base_url)
    end

    def styles
      self.class.styles.map do |_, size|
        width, height = size[/(\d+)x(\d+)/].split("x")
        {
          url: polymorphic_path(attachment.variant(resize: size), only_path: true),
          width: width,
          height: height,
        }
      end
    end
  end
end
