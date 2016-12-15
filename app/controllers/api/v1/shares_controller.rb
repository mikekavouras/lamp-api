module Api
  module V1
    class SharesController < ApiController
      before_action :require_interaction_id, only: [:create]
      before_action :require_interaction, only: [:create]
      before_action :require_share_id, only: [:destroy]
      before_action :require_share, only: [:destroy]

      def create
        @share = current_user.shares.new(share_params)

        @share.interaction = interaction

        if share.save
          render json: share
        else
          render json: { error: "invalid_share", errors: share.errors }
        end
      end

      def destroy
        share.destroy

        head :ok
      end

      private

      def share_params
        params.permit(
          :usage_limit,
          :expires_at,
        )
      end

      def interaction_id
        "#{params[:interaction_id]}"
      end

      def interaction
        @interaction ||= current_user.interactions.where(id: interaction_id).first
      end

      def share_id
        "#{params[:id]}"
      end

      def share
        @share ||= current_user.shares.where(id: share_id).first
      end

      def require_share_id
        render json: { error: "no_share_id" }, status: 404 unless share_id.present?
      end

      def require_share
        render json: { error: "share_not_found" }, status: 404 unless share.present?
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

