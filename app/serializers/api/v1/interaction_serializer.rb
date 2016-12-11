module Api
  module V1
    class InteractionSerializer < ActiveModel::Serializer
      attributes \
        :name,
        :description,
        :photo,
        :user,
        :device,
        :red,
        :green,
        :blue,
        :pattern
    end
  end
end
