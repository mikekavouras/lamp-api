module Api
  module V1
    class InteractionSerializer < ActiveModel::Serializer
      attributes \
        :id,
        :name,
        :description,
        :red,
        :green,
        :blue,
        :pattern,
        :photo,
        :user_device,
        :user

      def photo
        PhotoSerializer.new(object.photo)
      end

      def user_device
        UserDeviceSerializer.new(object.user_device)
      end

      def user
        UserSerializer.new(object.user)
      end
    end
  end
end
