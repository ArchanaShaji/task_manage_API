#get a single task

module Queries
  class Task < Queries::BaseQuery
    argument :id, ID, required: true
    type Types::TaskType, null: true

    def resolve(id:)
      context[:current_user].tasks.find_by(id: id)
    end
  end
end
