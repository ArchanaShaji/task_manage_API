module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :phone, String, null: false
    field :status, Boolean, null: false
  end
end