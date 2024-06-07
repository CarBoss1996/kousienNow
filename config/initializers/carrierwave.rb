# CarrierWave.configure do |config|
#   config.storage    = :aws
#   config.aws_bucket = ENV['S3_BUCKET_NAME'] # S3のバケット名
#   config.aws_acl    = 'public-read' # ファイルのアクセス許可設定
#   config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

#   config.aws_credentials = {
#     access_key_id:     ENV['AWS_ACCESS_KEY_ID'], # AWSのアクセスキー
#     secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # AWSのシークレットアクセスキー
#     region:            ENV['AWS_REGION'], # リージョン
#   }
# end
unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_REGION'],
    }

    config.fog_directory = ENV['S3_BUCKET_NAME'] # S3のバケット名
    config.cache_storage = :fog
  end
end
