# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# カテゴリを本格的に本家Amazonから全量取得する場合に利用する。
# Amazon::Ecs.options = {
#     AWS_access_key_id: Rails.application.secrets.aws_access_key_id,
#     AWS_secret_key:    Rails.application.secrets.aws_secret_access_key
# }
# 参考は以下のサイトなど
# 　https://qiita.com/tatsuki-m/items/043f14e7d4504277c947
# 　http://nirasan.hatenablog.com/entry/2015/02/28/131433
# 　https://qiita.com/kobake@github/items/88001f62983211027f63

