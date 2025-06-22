class Task < ApplicationRecord
  has_many :completions, dependent: :destroy
end
