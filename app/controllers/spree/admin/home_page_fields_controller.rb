module Spree
  module Admin
    class HomePageFieldsController < ResourceController
      def create
        @home_page_field = Spree::HomePageField.new(home_page_field_params)
        @home_page_field.build_image(attachment: params[:home_page_field][:image])
        if @home_page_field.save
          flash[:success] = Spree.t(:home_page_field_created)
          redirect_to acton: :index
        else
          flash[:error] = Spree.t(:home_page_field)
          render :create
        end
      end

      def update
        @home_page_field = Spree::HomePageField.find(params[:id])
        @home_page_field.create_image(attachment: params[:home_page_field][:image]) if params[:home_page_field][:image]
        if @home_page_field.update(home_page_field_params)
          flash[:success] = Spree.t(:success_updeate, resource: Spree.t(:home_page_field))
        else
          flash[:error] = Spree.t(:failed_update, resource: Spree.t(:home_page_field))
        end
        render :edit
      end

      private

      def home_page_field_params
        params.require(:home_page_field).permit(:title, :content, :field_type, :home_page_section_id)
      end
    end
  end
end
