# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
      field :register_user, mutation: Mutations::RegisterUser
      field :login_user, mutation: Mutations::LoginUser
      field :create_task, mutation: Mutations::CreateTask
      field :update_task, mutation: Mutations::UpdateTask
      field :delete_task, mutation: Mutations::DeleteTask
  end
end
