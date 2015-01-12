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

setup = ROM.setup(memory: 'memory://playground') 

setup.schema do
  base_relation(:users) do
    repository :memory
  end
end

setup.mappers do
  define(:users) do
    model name: 'UserSummaryModel'

    attribute :name, :from => :username
    attribute :email
  end
end

rom = setup.finalize

entity = UserEntity.new username: 'Jane', email:'jane@example.com'
rom.schema.users << entity.to_h

UserSummaryModel.send(:include, Equalizer.new(:name, :email))

data = rom.read(:users).to_a.first
# BUG_1 entity = UserEntity.new data
require 'pry'; binding.pry
ap data

