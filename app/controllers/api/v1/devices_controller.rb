module Api
  module V1
    class DevicesController < ApiController
      before_action :require_device, only: [:show, :delete, :reset]

      def create
      end

      def index
      end

      def show

      end

      def delete
      end

      def reset
      end

      private

      def device_id
        "#{params[:device_id]}"
      end

      def device
        @device ||= current_user.devices.where(device_id).first if device_id.present?
      end

      def require_device
        render json: { error: "device_not_found" }, status: 404 unless device
      end
    end
  end
end

