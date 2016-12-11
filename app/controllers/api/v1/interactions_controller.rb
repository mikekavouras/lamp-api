module Api
  module V1
    class InteractionsController < ApiController
      before_action :require_user_device_id, only: [:create]
      before_action :require_user_device, only: [:create]
      before_action :require_interaction_id, only: [:show, :update, :destroy]
      before_action :require_interaction, only: [:show, :update, :destroy]

      def create
        @interaction = current_user.interactions.new(interaction_params)
        @interaction.user_device = user_device

        if interaction.save
          render json: interaction
        else
          render json: { error: "invalid_interaction", errors: interaction.errors }
        end
      end

      def index
        render json: interactions
      end

      def show
        render json: interaction
      end

      def update
        if interaction.update_attributes(interaction_params)
          render json: interaction
        else
          render json: { error: "invalid_interaction", errors: interaction.errors }
        end
      end

      def destroy
        interaction.destroy

        head :ok
      end

      private

      def interaction_params
        params.permit(
          :name,
          :description,
          :red,
          :green,
          :blue,
          :pattern
        )
      end

      def interaction_id
        "#{params[:id]}"
      end

      def interaction
        @interaction ||= current_user.interactions.where(id: interaction_id).first
      end

      def interactions
        @interactions ||= current_user.interactions.all
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

      def require_interaction_id
        render json: { error: "no_interaction_id" }, status: 404 unless interaction_id.present?
      end

      def require_interaction
        render json: { error: "interaction_not_found" }, status: 404 unless interaction.present?
      end
    end
  end
end

