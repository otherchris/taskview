# app/models/concerns/completable.rb
module Completable
  extend ActiveSupport::Concern

  included do
    has_many :completions, as: :completable, dependent: :destroy
  end

  def complete!
    completions.create!(assigned_date: next_date)
  end
end
