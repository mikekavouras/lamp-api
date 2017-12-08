class Photo < ApplicationRecord
  belongs_to :user

  has_many :interactions

  before_validation :set_token

  def url
    "https://#{Rails.application.secrets.aws_bucket}.s3.amazonaws.com/#{Rails.env.to_s}/uploads/#{self.token}.jpg"
  end

  def aws_upload_params(options={}) expires_at = options[:expires_at] || (Time.now + 48.hour)
    max_file_size = options[:max_file_size] || 1.gigabyte
    acl = options[:acl] || 'public-read'
    starts_with = options[:starts_with] || "#{Rails.env.to_s}/uploads/#{self.token}.jpg"
    bucket = Rails.application.secrets.aws_bucket
    # This used to include , but it threw Server IO errors
    policy = Base64.encode64(
      "{'expiration': '#{expires_at.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z')}',
        'conditions': [
          ['starts-with', '$key', '#{starts_with}'],
          ['starts-with', '$hash', '#{self.token}'],
          ['starts-with', '$utf8', ''],
          ['starts-with', '$x-requested-with', ''],
          ['starts-with', '$content-type', 'image/jpeg'],
          ['eq', '$success_action_status', '201'],
          ['content-length-range', 0, #{max_file_size}],
          {'bucket': '#{bucket}'},
          {'acl': '#{acl}'},
          {'success_action_status': '201'}
        ]
      }").gsub(/\n|\r/, '')

    signature = Base64.encode64(
                  OpenSSL::HMAC.digest(
                    OpenSSL::Digest.new('SHA1'),
                    Rails.application.secrets.aws_secret_access_key, policy)).gsub("\n","")

    {
      "key" => "#{starts_with}",
      "hash" => "#{self.token}",
      "utf8" => "",
      "content-type" => "image/jpeg",
      "x-requested-with" => "",
      "AWSAccessKeyId" => "#{Rails.application.secrets.aws_access_key_id}",
      "acl" => "#{acl}",
      "policy" => "#{policy}",
      "signature" => "#{signature}",
      "success_action_status" => "201"
    }
  end

  private

  def set_token
    self.token ||= SecureRandom.urlsafe_base64(32)
  end
end
