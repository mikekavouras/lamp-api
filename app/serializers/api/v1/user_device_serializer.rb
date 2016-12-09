module Api
  module V1
    class UserDeviceSerializer < ActiveModel::Serializer
      attributes \
        :name,
        :device

      private

      def device
        object.device
      end
    end
  end
end
