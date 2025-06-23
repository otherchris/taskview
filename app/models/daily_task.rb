class DailyTask < ApplicationRecord
  has_many :completions, as: :completable, dependent: :destroy
end
