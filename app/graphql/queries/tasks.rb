#get all tasks

module Queries
  class Tasks < Queries::BaseQuery
    type [Types::TaskType], null: false

    def resolve
      context[:current_user].tasks.order(:due_date)
    end
  end
end