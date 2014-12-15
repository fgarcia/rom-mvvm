require 'soa/rom_adapters'

module Mappers

  def self.customerAPI
    # ROM.setup(github_rom_org: 'github://orgs/rom-rb') do
    ROM.setup(hash_rom: 'hash://soa/customer-api') do

      schema do
        base_relation :repos do
          repository :hash_rom

          attribute :first_name
        end
      end

      relation(:repos) do
        # no relations ???
        # just plain transformation
      end

      mappers do
        define(:repos) do
          model Repo
          attribute :first_name, from: 'name'
        end
      end
    end

  end
end

