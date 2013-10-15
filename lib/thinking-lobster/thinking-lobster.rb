require 'mongoid'
require 'active_support'
module ThinkingLobster

#Test Scenarios:
 # [x] Initial creation
 # []  reviewing an item waayy after it was due.
 # []  reviewing an item too soon.
 # [X]  New item incorrect
 # []  Old item incorrect
 # [x] New item correct
 # [] Old item correct

#TODO:
 # [] Move all fixed numbers into user definable vars. eg. default review_due_at, intervals, etc
 # [] Remove active support dependecy in favor of manual caluclations for .days, .hours, etc

  def self.included(collection)
    #Make all of the hardcoded 2's a user defined variable.
    collection.send :field, :current_interval, type: Integer, default: 2
    collection.send :validates, :current_interval, numericality: { greater_than: 0 }
    collection.send :field, :times_reviewed, type: Integer, default: 0
    collection.send :field, :winning_streak, type: Integer, default: 0
    collection.send :field, :losing_streak, type: Integer, default: 0
    collection.send :field, :review_due_at, type: Time, default: ->{Time.now + 2.hours}
  end

  def mark_correct!(current_time = Time.now)
    time_since_due = (self.review_due_at - current_time)
    increment_wins
    if time_since_due < 36.hours
      new_item_correct(current_time)
    else
      old_item_correct(current_time)
    end
    self.save
  end

  def mark_incorrect!(current_time = Time.now)
    time_since_due = (self.review_due_at - current_time)
    increment_losses
    if time_since_due < 36.hours
      #Review time after early failure is Time.now
      new_item_incorrect(current_time)
    else
      old_item_incorrect(current_time)
    end
    self.save
  end

private

  def new_item_correct(current_time)
    #Takes the interval between current_time and the time the item was due
    # And doubles that amount of time.
    interval = (current_time - self.review_due_at)*2 #That multiplier needs to be a variable, not hardcoded.
    self.current_interval = interval
    self.review_due_at = current_time + interval
  end

  def old_item_correct(current_time)
  end

  def new_item_incorrect(current_time)
    #Resets progress if you don't get it right when it's new
    self.current_interval = 2.hours
    self.review_due_at    = current_time
  end

  def old_item_incorrect(current_time)
    self.current_interval /= 3
    self.review_due_at    = current_time
  end

  def increment_wins
    self.winning_streak += 1
    self.losing_streak   = 0
  end

  def increment_losses
    self.winning_streak = 0
    self.losing_streak += 1
  end

end
