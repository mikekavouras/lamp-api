module Api
  module V1
    class PhotoSerializer < ActiveModel::Serializer
      attributes \
        :id,
        :filename,
        :ext,
        :mime_type,
        :original_width,
        :original_height,
        :sha,
        :token,
        :ip_address
    end
  end
end
