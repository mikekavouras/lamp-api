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
        :pattern

      belongs_to :photo
      belongs_to :user_device
      belongs_to :user
    end
  end
end
