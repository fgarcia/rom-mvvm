require 'virtus'
require 'rom'
require 'rom/adapter/memory'
require 'awesome_print'
require 'pry'

class UserEntity
  include Virtus.model

  attribute :username, String
  attribute :email, String
  attribute :last_login, Time
end

class UserSummaryModel
  include Virtus.model

  attribute :name, String
  attribute :email, String
end


setup = ROM.setup(memory: 'memory://playground') 

setup.schema do
  base_relation(:users) do
    repository :memory
  end
end

setup.mappers do
  define :users do
    model name: 'RomUser'

    # ??? Reproduce UserEntity definition ???
    attribute :username
    attribute :email
    attribute :last_login
  end

  define(:summary, :parent => :users) do
    model name: 'RomUserSummary'

    attribute :name, :from => :user_name
    attribute :email
  end
end

rom = setup.finalize

jane_hash = { username: 'Jane', email:'jane@example.com' }
rom.schema.users << jane_hash
rom.schema.users << { username: 'Markus', email:'mark@foo.com' }

# Why is this needed?
RomUser.send(:include, Equalizer.new(:username, :email))
RomUserSummary.send(:include, Equalizer.new(:name, :email))

data = rom.read(:users).to_a.first
# BUG_1 entity = UserEntity.new data
ap data

# BUG_2 data = rom.read(:users).summary.to_a.first
# model = UserSummaryModel.new data
ap data

#####################################################################
# Step 2

# Existing UserEntity provided already by external ORM
entity = UserEntity.new jane_hash

# BUG_3 
#
# Transform Entity into UserSummaryModel ???
# ... I assume these steps:
#
# 1. Add Entity hash to rom.schema
# rom.schema.users << entity.to_hash
#
# 2. Extract model
# data = rom.read(:users).summary.to_a.first
#
# 3. Free rom.schema
# ????

