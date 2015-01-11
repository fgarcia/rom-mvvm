#
# Adding mapping concepts to Virtus 


# Your core User concept object
#
# Virtus.entity is the current (Virtus.model)
#
class UserEntity
  include Virtus.entity

  attribute :id, String
  attribute :username, String
  attribute :email, String
  attribute :age, Integer
  attribute :birthday, DateTime

  def client?
    ....
  end

end

# Virtus.value_object do not necessary need a link to their entity
#
class UserLoginModel
  include Virtus.value_object

  attribute :login, String
  attribute :password, String
end


# Virtus.model is linked to the central Entity using the same id but only
# expose given attributes (or define new ones). The idea is having the sexy
# attribute representation of Virtus and provide an easy way to effortlessly
# build related model objects out of the Entity

class UserSummaryModel
  include Virtus.model

  # FEATURE: create a relationship, (1) 'id' relation (2) share same repo
  entity UserEntity

  # FEATURE: pull attribute default parameters from Entity
  attribute :username
  attribute :email

  # FEATURE: expose helpers/methods from Entity
  method :client?
end

class UserDetailsModel
  include Virtus.model

  entity UserEntity

  # FEATURE: maps attributes under a different name
  attribute :name, from: 'username'
  attribute :email

  # FEATURE: local validation
  validates :name, presence: true
end
