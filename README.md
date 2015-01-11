# ROM for MVVM programming

In the traditional MVC Rails way, ActiveRecord models tend to easily grow fat
and leak database concerns. This example shows how to use ROM not as an
alternative database ORM, but as a model mapper tool for a MVVM architecture.

## Multiple ViewModels from a core idea

Normally the first class to grow fat is the User class. In MVVM it is common 
to have one central class representing users but several model views of them.
As an example, given a central UserEntity class, we might need several related
model representations like:

  UserLoginModel
  UserSignupModel
  UserProfileModel
  UserSettingsModel
  UserDetailsModel
  UserSummaryModel
  UserApiModel

All these models are related either with a single form, view or service. That
is the origin of the ViewModel concept of MVVM: one model for each view (or
usage) of your data. 

I used the suffix Entity to emphasize that a UserEntity is a core concept from
where a set of models is born. The listed user models are the objects managed
by the views and controllers, these might not even have access the central
entity, although most of them will likely share the same id.

Many people know this better as the presenter pattern, but in MVVM we assume
that all views deal exclusively with presenters, hence the tendency of naming
these objects as ViewModels.

## The Rails Way

In Rails we got used that to a central god User class defining validations. In
MVVM those are distributed among different models. Therefore you can isolate
different sets of validations on the models that target their specific use
case. You will still use validations in your central UserEntity for state
validations, but now you can isolate input validations that are only related to
one form.

The use of ActiveRecord patterns tends to make a single database table or
document out of the User class. With MVVM your user models will not depend on
how UserEntity is stored:

1. **UserLoginModel** is related to a single form and solves in a more elegant
   way the security issues that Rails 4 tries to cover with strong parameters.
Technically it is just a temporal value object that needs no storage, but is
useful to communicate with Service objects.

2. **UserSummaryModel** is a reduced set of fields out of the central
   UserEntity, like the ones we need for a table with one row per user. This
might be such a frequent visualization of the UserEntity that we might want to
optimize performance with an index. This model can be generated directly out of
the index view without mapping out of the database lots of heavy full blown
entity objects.

3. **UserApiModel** is just one of the many models related with the API access.
   In Rails you are likely to have your ORM dedicated to your models single
database and use Rabl, jbuilder... as a secondary API ORM of the same Entity.

4. Since your controller and views deals directly with user models that have no
   corelation with your database, it will be easier replacing the storage of
your UserEntity. You might move users out of your central database into Redis,
an external micro service or anything that requires a different ORM.  Even if
your attributes are defined in a new different way, your models not.  They are
like plain structures less concerned about coercion and storage representation.

## A ROM Solution

Although ROM can give you a full blown database ORM, you can also use it as
a plain object mapper and wrap your existing code base into a custom
**UserRepository** 

ROM does have the concept of repository, but depending on your architecture you
might prefer your repositories has POROs that are heavily modified without
knowledge of ROM and wrap existing ORMs that you are more familiar with.

This repository can fetch a single UserEntity by id, but each query will return
a different kind of model.

(
  See enum/array adapter:
  https://gist.github.com/fgarcia/189e2dc221fc51084780
)

## TODO - The challange

- Ease model definitions by inheriting limited set of attributes

- Redefine layout of entity on each model

- Explore how ROM can overlap with rabl / jbuilder but integrate only with the
  API part (Grape?)

- Share-forward selected functions from models to entity


