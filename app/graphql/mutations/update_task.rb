module Mutations
  class UpdateTask < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :status, String, required: false
    argument :due_date, GraphQL::Types::ISO8601Date, required: false

    field :task, Types::TaskType, null: true
    field :errors, [String], null: false

    def resolve(id:, title: nil, status: nil, due_date: nil)
      task = context[:current_user].tasks.find_by(id: id)
      return { task: nil, errors: ["Task not found"] } unless task

      if task.update(title: title, status: status, due_date: due_date)
        { task: task, errors: [] }
      else
        { task: nil, errors: task.errors.full_messages }
      end
    end
  end
end