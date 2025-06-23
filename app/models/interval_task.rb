class IntervalTask < ApplicationRecord
  has_many :completions, as: :completable, dependent: :destroy
end
