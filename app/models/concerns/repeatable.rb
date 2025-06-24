# app/models/concerns/repeatable.rb
module Repeatable
  extend ActiveSupport::Concern

  included do
    enum :repeats, {
      no_repeats: "no_repeats",
      daily: "daily",
      weekly: "weekly",
      monthly: "monthly",
      annually: "annually"
    }, prefix: true
  end

  def advance_date(date)
    return date if repeats_no_repeats?

    duration = case repeats.to_sym
    when :daily then {days: repeats_every}
    when :weekly then {weeks: repeats_every}
    when :monthly then {months: repeats_every}
    when :annually then {years: repeats_every}
    end
    date.advance(duration)
  end
end
