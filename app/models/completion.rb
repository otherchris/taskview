class Completion < ApplicationRecord
  belongs_to :completable, polymorphic: true
end
