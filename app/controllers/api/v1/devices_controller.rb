module Api
  module V1
    class DevicesController < ApiController
      before_action :require_device, only: [:create, :presence]
      before_action :require_user_device_id, only: [:show, :delete, :reset]
      before_action :require_user_device, only: [:show, :delete, :reset]

      def create
        # TODO is this the right behavior to overwrite the name and direct?

        @user_device = current_user.user_devices.where(device: device).first
        @user_device ||= current_user.user_devices.new(device: device)
        @user_device.name = params[:name]
        @user_device.direct = true

        if user_device.save
          render json: user_device
        else
          render json: { error: "invalid_device", errors: user_device.errors }, status: :unprocessable_entity
        end
      end

      def index
        render json: {
          user_devices: user_devices.map { |user_device| UserDeviceSerializer.new(user_device) }
        }
      end

      def update
        user_device.update_attributes(device_params)
        render json: user_device
      end

      def show
        render json: user_device
      end

      def destroy
        user_device.destroy

        head :ok
      end

      def reset
        user_device.device.user_devices.destroy_all

        head :ok
      end

      def presence
        if params[:presence] && ["true", "false"].include?(params[:presence])
          presence = params[:presence] == "true" ? true : false
          device.update_attribute(:presence, presence)
          head :ok
        end
      end

      private

      def device_params
        params.permit(:particle_id, :name)
      end

      def particle_id
        params[:particle_id]
      end

      # coreid is sent from particle webhooks
      def coreid
        params[:coreid]
      end

      def device_id
        "#{(particle_id || coreid)}".downcase
      end

      def device
        @device ||= Device.where(particle_id: device_id).first
      end

      def user_device_id
        "#{params[:id]}"
      end

      def user_device
        @user_device ||= current_user.user_devices.includes(:device).where(id: user_device_id).first
      end

      def user_devices
        @user_devices ||= current_user.user_devices.includes(:device).all
      end

      def require_device
        render json: { error: "particle_device_not_found" }, status: 404 unless device.present?
      end

      def require_user_device_id
        render json: { error: "no_device_id" }, status: 404 unless user_device_id.present?
      end

      def require_user_device
        render json: { error: "device_not_found" }, status: 404 unless user_device.present?
     end
    end
  end
end

