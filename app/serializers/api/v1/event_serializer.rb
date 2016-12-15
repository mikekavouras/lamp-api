module Api
  module V1
    class EventSerializer < ActiveModel::Serializer
      attributes \
        :id,
        :user,
        :interaction,
        :status,
        :response,
        :error
    end
  end
end
