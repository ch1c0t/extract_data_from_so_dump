require 'redis'

Token = Redis.new db: 2
Meta  = Redis.new db: 15

keys = Token.keys '*'
Meta.sadd 'keys', keys
