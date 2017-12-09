module Api
  module V1
    class DeviceSerializer < ActiveModel::Serializer
      attributes \
        :particle_id,
        :name,
        :params,
        :last_heard_at

      private

      def params
        object.parsed_params
      end
    end
  end
end
