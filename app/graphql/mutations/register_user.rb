module Mutations
  class RegisterUser < BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true
    argument :phone, String, required: true
    argument :status, Boolean, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(name:, email:, password:, phone:, status:)
      user = User.new(name: name, email: email, password: password, phone: phone, status: status)
      if user.save
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
