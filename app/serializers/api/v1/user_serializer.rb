module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes \
        :id,
        :anonymous
    end
  end
end
