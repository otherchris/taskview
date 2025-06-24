require "test_helper"

class IntervalTaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "can be saved" do
    interval_task = build(:interval_task)
    assert interval_task.save, "Could not save the interval task"
  end

  test "defaults to not repeating" do
    interval_task = IntervalTask.new
    assert_equal "no_repeats", interval_task.repeats
  end

  test "repeats_every defaults to 1" do
    interval_task = IntervalTask.new
    assert_equal 1, interval_task.repeats_every
  end

  test "last_date is set on create" do
    travel_to Time.zone.local(2025, 6, 24, 12, 0, 0) do
      interval_task = create(:interval_task)
      assert_equal Time.zone.local(2025, 6, 24, 12, 0, 0), interval_task.last_date
    end
  end

  test "next_date returns the last_date plus the repeats_every times the repeat" do
    travel_to Time.zone.local(2025, 6, 24, 12, 0, 0) do
      interval_task = create(:interval_task, repeats: "daily", repeats_every: 4)
      expected_next_date = Time.zone.local(2025, 6, 28, 12, 0, 0)
      assert_equal expected_next_date, interval_task.next_date
    end
  end

  test "#complete! creates a completion and updates last_date" do
    interval_task = create(:interval_task)
    original_last_date = interval_task.last_date

    travel_to Time.zone.local(2025, 6, 24, 12, 0, 0) do
      assert_difference("Completion.count", 1) do
        interval_task.complete!
      end

      interval_task.reload
      assert_not_equal original_last_date, interval_task.last_date
      assert_equal Time.zone.local(2025, 6, 24, 12, 0, 0), interval_task.last_date
      assert_equal Time.zone.today, interval_task.completions.last.assigned_date
    end
  end
end
