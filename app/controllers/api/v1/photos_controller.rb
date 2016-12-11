module Api
  module V1
    class PhotosController < ApiController
      before_action :require_photo_id, only: [:update]
      before_action :require_photo, only: [:update]

      def index
        render json: photos
      end

      def create
        @photo = current_user.photos.new
        @photo.ip_address = request.remote_ip

        if photo.save
          render json: photo.aws_upload_params
        else
          render json: { error: "invalid_photo", errors: photo.errors }
        end
      end

      def update
        if photo.update_attributes(photo_params)
          render json: photo
        else
          render json: { error: "invalid_photo", errors: photo.errors }
        end
      end

      private

      def photo_params
        params.permit(
          :filename,
          :ext,
          :mime_type,
          :original_width,
          :original_height,
          :sha
        )
      end

      def photo_id
        "#{params[:id]}"
      end

      def photo
        @photo ||= current_user.photos.where(id: photo_id).first
      end

      def photos
        @photos ||= current_user.photos.all
      end

      def require_photo_id
        render json: { error: "no_photo_id" }, status: 404 unless photo_id.present?
      end

      def require_photo
        render json: { error: "photo_not_found" }, status: 404 unless photo.present?
      end
    end
  end
end

