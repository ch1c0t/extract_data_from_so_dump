require 'redis'

Questions = Redis.new
Tokens    = Redis.new db: 2

ids = Questions.keys '*'
ids.each do |id|
  question = Questions.hget id, 'title'
  tokens = question.split /\s+|\b/
  Tokens.rpush id, tokens
end
