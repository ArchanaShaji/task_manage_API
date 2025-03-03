module Mutations
  class CreateTask < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: false
    argument :status, String, required: true
    argument :due_date, GraphQL::Types::ISO8601Date, required: true

    field :task, Types::TaskType, null: true
    field :errors, [String], null: false

    def resolve(title:, description:, status:, due_date:)
      user = context[:current_user]
      return { task: nil, errors: ["Unauthorized"] } unless user

      task = context[:current_user].tasks.build(title: title, description: description, status: status, due_date: due_date)
      
      if task.save
        { task: task, errors: [] }
      else
        { task: nil, errors: task.errors.full_messages }
      end
    end
  end
end