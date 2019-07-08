module Spree
  class InstagramUserImage < Asset
    include Configuration::ActiveStorage
    include Rails.application.routes.url_helpers

    def image_url
      create_path(:normal)
    end

    def styles
      self.class.styles.map do |_, size|
        width, height = size[/(\d+)x(\d+)/].split('x')

        {
          url: create_path(size),
          width: width,
          height: height,
        }
      end
    end

    private

    def create_path(size)
      polymorphic_path(attachment.variant(resize: size), only_path: true)
    end
  end
end
