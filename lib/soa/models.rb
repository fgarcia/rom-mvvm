# Customer
#
# Single model class of this example. All other 'models' are directly related
# with this central definition
#
# In DDD this is an Entity or an Aggregate Root. The object that should have
# model logic. 
#
# All other related models will normally be read-only projections and share the
# same ID field
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
#
# Properties shown in each row of a table of 'Customer' objects
#
# This is not always one result of Customer.all, in a CQRS style this might be
# a single result of an indexed view, where only the needed fields are
# listed. Technically there might be as many proyection-models as views of
# the same Customer are needed
#
# Plain view-model object, mostly attributes without much logic, if any.
#
class CustomerRow
  attribute :name, String
end

class CustomerDetails
  # only the properties shown in a detailed view of 'Customer' objects
  # Same type of class as 'CustomerRow' 
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
