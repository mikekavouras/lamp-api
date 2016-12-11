module Api
  module V1
    class InvitesController < ApiController
      before_action :require_user_device_id, only: [:create]
      before_action :require_user_device, only: [:create]
      before_action :require_invite, only: [:accept]

      def create
        @invite = current_user.invites.new(invite_params)
        @invite.device = user_device.device

        if invite.save
          render json: invite
        else
          render json: { error: "invalid_invite", errors: invite.errors }
        end
      end

      def accept
        success = false

        ActiveRecord::Base.transaction do
          invite.accept
          @user_device = current_user.user_devices.where(device: invite.device, name: params[:name], direct: false).first
          @user_device ||= current_user.user_devices.new(device: invite.device, name: params[:name], direct: false, invite: invite)
          success = @user_device.save
        end

        if success
          render json: user_device
        else
          render json: { error: "invalid_device", errors: user_device.errors }, status: :unprocessable_entity
        end
      end

      private

      def invite_params
        params.permit(
          :usage_limit,
          :expires_at,
        )
      end

      def token
        "#{params[:token]}"
      end

      def invite
        @invite ||= Invite.find_by_token(token)
      end

      def user_device_id
        "#{params[:id]}"
      end

      def user_device
        @user_device ||= current_user.user_devices.includes(:device).where(id: user_device_id).first
      end

      def require_user_device_id
        render json: { error: "no_device_id" }, status: 404 unless user_device_id.present?
      end

      def require_user_device
        render json: { error: "device_not_found" }, status: 404 unless user_device.present?
      end

      def require_invite
        render json: { error: "invite_not_found" }, status: 404 unless invite.present?
      end
    end
  end
end

