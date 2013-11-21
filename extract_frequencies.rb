require 'redis'

Meta        = Redis.new db: 15
Tokens      = Redis.new db: 2
Frequencies = Redis.new db: 3

ids = Meta.smembers 'keys'
ids.each do |id|
  first_word = Tokens.lindex id, 0
  Frequencies.zincrby 'unigrams', 1, first_word
end
