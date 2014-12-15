# Customer
#
# Single model class of this example. All other 'models' are directly related
# with this central definition
#
# ??? How to reference this from all other definitions ???
# ... such feature looks more useful for documentation than code
#
class Customer
  include Virtus.model

  attribute :name, String
end

# Transformation of Customer 
# Format used by the database that stores Customer models
class CustomerStore

  include Virtus.model

  attribute :f_name, String
end


# Transformation of Customer 
# Format used by the external API serving Customer models
class CustomerAPI
  include Virtus.model

  attribute :first_name, String
end

# Partial definition of Customer ???
#
# Instead a 'transformation' it could be the definition of Customer fields used
# in the front-end / form. Related with Rails strong parameters (mass
# assignment protection)
#
class CustomerForm
  # TODO
end
