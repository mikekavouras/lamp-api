module Api
  module V1
    class EventsController < ApiController
      def index
        render json: events
      end

      private

      # TODO paginate
      def events
        @events ||= current_user.events.all
      end
    end
  end
end

