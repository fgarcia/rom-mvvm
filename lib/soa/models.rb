# Customer
#
# Single model class of this example. All other 'models' are directly related
# with this central definition
#
# ??? How to reference this from all other definitions ???
#   - for documentation, graph generation
#   - assign default attribute type of other models related with this one
#
class Customer
  include Virtus.model

  attribute :id, String
  attribute :name, String
  attribute :email, String
  attribute :address, String
  attribute :phone, String
end

# Proyection of Customer
class CustomerRow
  # ... only the properties shown in a table of 'Customer' objects
  attribute :name, String
end

class CustomerDetails
  # ... only the properties shown in a detailed view of 'Customer' objects
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
