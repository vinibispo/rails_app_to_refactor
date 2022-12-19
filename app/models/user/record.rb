# frozen_string_literal: true

module User
  class Record < ApplicationRecord
    self.table_name = 'users'
    has_many :todos, class_name: '::Todo::Item::Record'

    validates :email, uniqueness: true
    validates :token, uniqueness: true
    validates :password_digest, presence: true, length: { is: 64 }
  end
end
