# frozen_string_literal: true

module Todo::Item
  class Record < ApplicationRecord
    self.table_name = 'todos'

    belongs_to :user, class_name: '::User::Record'

    scope :overdue, -> { uncompleted.where('due_at <= ?', Time.current) }
    scope :completed, -> { where.not(completed_at: nil) }
    scope :uncompleted, -> { where(completed_at: nil) }

    validates :title, presence: true
    validates :due_at, presence: true, allow_nil: true
    validates :completed_at, presence: true, allow_nil: true

    def overdue?
      return false if !due_at || completed_at

      due_at <= Time.current
    end

    def uncompleted?
      completed_at.nil?
    end

    def completed?
      !uncompleted?
    end

    def status
      return 'completed' if completed?
      return 'overdue' if overdue?

      'uncompleted'
    end
  end
end
