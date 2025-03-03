module Types
  class TaskType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :status, Integer, null: false
    field :due_date, GraphQL::Types::ISO8601Date, null: false
    field :user, Types::UserType, null: false
  end
end