require 'data_mapper'
require 'timeout'

if ENV['SUPW'].nil?
  puts 'SUPW environment variable must be set'
  exit 1
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
rooms = ENV['ROOMS']
exit if rooms.nil?
id = 1
rooms.split(',').each do |room|
  puts "Creating #{room}"
  Channels.create(
  channel_id: id,
  server_id: 1,
  parent_id: 0,
  name: room,
  inheritacl: 1)
  id = id + 1
end
p Channels.all
