module Mutations
  class DeleteTask < BaseMutation
    argument :id, ID, required: true

    field :message, String, null: false

    def resolve(id:)
      task = context[:current_user].tasks.find_by(id: id)
      return { message: "Task not found" } unless task

      task.destroy
      { message: "Task deleted successfully" }
    end
  end
end