module Api
  module V1
    class InviteSerializer < ActiveModel::Serializer
      attributes \
        :id,
        :expires_at,
        :revoked_at,
        :usage_limit,
        :usage_count,
        :token
    end
  end
end
