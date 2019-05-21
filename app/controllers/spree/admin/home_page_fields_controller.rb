module Spree
  module Admin
    class HomePageFieldsController < ResourceController
      def create
        @home_page_field = Spree::HomePageField.new(home_page_field_params)
        @home_page_field.build_image(attachment: image_params) if image_params
        if @home_page_field.save
          flash[:success] = flash_message_for(@home_page_field, :successfully_created)
          redirect_to action: :index
        else
          flash[:error] = Spree.t(:could_not_create_page_field)
          render :new
        end
      end

      def update
        @home_page_field = Spree::HomePageField.find(params[:id])
        @home_page_field.create_image(attachment: image_params) if image_params
        if @home_page_field.update(home_page_field_params)
          flash[:success] = flash_message_for(@home_page_field, :successfully_updated)
        else
          flash[:error] = Spree.t(:could_not_update_page_field)
        end
        render :edit
      end

      private

      def image_params
        params[:home_page_field][:image]
      end

      def home_page_field_params
        params.require(:home_page_field).permit(:name, :title, :content, :field_type, :home_page_section_id)
      end
    end
  end
end
