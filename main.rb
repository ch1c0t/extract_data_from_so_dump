# HugeXML is taken from https://github.com/amolpujari/reading-huge-xml
# Kudos to Amol Pujari!
require './reading-huge-xml/reading_huge_xml'
require 'redis'

Questions = Redis.new
Tags      = Redis.new db: 1

def extract_tags_from string
  string.scan(/<([^>]*)>/).flatten
end

HugeXML.read "../Posts.xml", ['row'] do |element|
  attributes = element[:attributes]

  if attributes['PostTypeId'] == '1' # Is it a question?
    id = attributes['Id']

    Questions.hmset id, 'title', attributes['Title'], 'body', attributes['Body']
    extract_tags_from(attributes['Tags']).each do |tag|
      Tags.sadd id, tag
    end
  end
end
