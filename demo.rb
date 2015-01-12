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
  attribute :admin, Boolean
end

# class UserRowModel
#   include Virtus.model
# end

setup = ROM.setup(memory: 'memory://users') 

setup.schema do
  base_relation(:row) { repository :memory }
  base_relation(:edit) { repository :memory }
end

setup.mappers do
  define(:row) do
    model name: 'UserRowModel'
    #model UserRowModel
    attribute :name, :from => :username
    attribute :email
  end

  define(:edit) do
    model name: 'UserEditModel'
    attribute :username
    attribute :email
  end
end

rom = setup.finalize
# UserRowModel.send(:include, Equalizer.new(:name, :email))

entity = UserEntity.new username: 'Jane', email: 'jane@example.com'

rom.schema.row << entity.to_h
user_model_row = rom.read(:row).to_a.first

rom.schema.edit << entity.to_h
user_model_edit = rom.read(:edit).to_a.first



