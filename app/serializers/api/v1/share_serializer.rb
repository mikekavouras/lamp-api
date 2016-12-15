module Api
  module V1
    class ShareSerializer < ActiveModel::Serializer
      attributes \
        :id,
        :usage_count,
        :usage_limit,
        :expires_at,
        :url

      belongs_to :user
      belongs_to :interaction
    end
  end
end
