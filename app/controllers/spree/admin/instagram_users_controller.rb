module Spree
  module Admin
    class InstagramUsersController < ResourceController
      def create
        @instagram_user = Spree::InstagramUser.new(instagram_user_basic_params)
        @instagram_user.build_image(attachment: image_params) if image_params
        @instagram_user.instagram_posts << Spree::InstagramPost.find(post_id_param) if post_id_param.present?

        if @instagram_user.save
          flash[:success] = flash_message_for(@instagram_user, :successfully_created)
          if post_id_param.empty?
            redirect_to edit_admin_instagram_user_path(@instagram_user)
          else
            redirect_to hashtag_admin_instagram_posts_path
          end
        else
          flash[:error] = Spree.t(:could_not_create_instagram_user)
          render :new
        end
      end

      def update
        @instagram_user = Spree::InstagramUser.find(params[:id])
        @instagram_user.create_image(attachment: image_params) if image_params
        if @instagram_user.update(instagram_user_basic_params)
          flash[:success] = flash_message_for(@instagram_user, :successfully_updated)
        else
          flash[:error] = Spree.t(:could_not_update_instagram_user)
        end
        render :edit
      end

      private

      def instagram_user_basic_params
        instagram_user_params.slice(:name, :username)
      end

      def image_params
        params[:instagram_user][:image]
      end

      def post_id_param
        params[:instagram_user][:post_id]
      end

      def instagram_user_params
        params.require(:instagram_user).permit(:name, :username, :image)
      end
    end
  end
end
