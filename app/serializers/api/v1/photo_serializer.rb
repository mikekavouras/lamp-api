module Api
  module V1
    class PhotoSerializer < ActiveModel::Serializer
      attributes \
        :filename,
        :ext,
        :mime_type,
        :original_width,
        :original_height,
        :sha,
        :ip_address
    end
  end
end
