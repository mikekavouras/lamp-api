module Api
  module V1
    class DeviceSerializer < ActiveModel::Serializer
      attributes \
        :particle_id,
        :name,
        :params

      private

      def params
        object.parsed_params
      end
    end
  end
end
