require 'data_mapper'
require 'timeout'

if ENV['SUPW'].nil?
  puts 'SUPW environment variable must be set'
  exit
end

# Set SupepUser password and create initial database
`/usr/sbin/murmurd -fg -supw #{ENV['SUPW']}`

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite:///var/lib/mumble-server/mumble-server.sqlite')

# Channels sqlite table
class Channels
  include DataMapper::Resource
  property :server_id,  Integer
  property :channel_id, Serial
  property :parent_id,  Integer
  property :inheritacl, Integer
  property :name,       Text
end

DataMapper.finalize

# Create channels
room = ENV['ROOM1_NAME']
id = 1
while true
  break if room.nil?
  puts "Creating #{room}"
  Channels.create(
  channel_id: id,
  server_id: 1,
  parent_id: 0,
  name: room,
  inheritacl: 1)
  id = id + 1
  room = ENV["ROOM#{id}_NAME"]
end
p Channels.all
