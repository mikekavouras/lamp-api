module Api
  module V1
    class DevicesController < ApiController
      before_action :require_device, only: [:create]
      before_action :require_user_device, only: [:show, :delete, :reset]

      def create
        @user_device = current_user.user_devices.create(device: device, name: params[:name], direct: true)

        render json: user_device
      end

      def index
        render json: user_devices
      end

      def show
        render json: user_device
      end

      def delete
      end

      def reset
      end

      private

      def particle_id
        "#{params[:particle_id]}"
      end

      def device
        @device ||= Device.where(particle_id: particle_id).first
      end

      def user_device_id
        "#{params[:id]}"
      end

      def user_device
        @user_device ||= current_user.user_devices.includes(:device).where(id: user_device_id).first if user_device_id.present?
      end

      def user_devices
        @user_device ||= current_user.user_devices.includes(:device).all
      end

      def require_device
        render json: { error: "device_not_found" }, status: 404 unless device
      end

      def require_user_device
        render json: { error: "device_not_found" }, status: 404 unless user_device
      end
    end
  end
end

