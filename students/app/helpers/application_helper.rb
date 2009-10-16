# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def duration_in_words(duration)
    hours = (duration / 1.hour).to_i
    minutes = ((duration % 1.hours) / 1.minute).to_i
    
    result = ""
    if hours == 1
      result += "1 час"
    elsif hours > 1
      result += "#{hours} часа"
    end

    if minutes == 1
      result += " 1 минута"
    elsif minutes > 1
      result += " #{minutes} минути"
    end
    
    result
  end
  
  # Returns true if the user can still submit problems in the given contest, false otherwise
  def can_user_submit_in_contest?(user, contest)
    contest.user_open_time(user) and contest.allow_user_submit(user)
  end
  
  # Returns the nicely formatted string representation of the time left for a
  # particular student to submit solutions to a given contest.
  # 
  # If no time is left, this method returns 0.
  def time_left_for_user_in_contest(user, contest)
    result = 0 # No time left.
    if can_user_submit_in_contest?(user, contest)
      result = duration_in_words(contest.duration.minutes - (Time.now - contest.user_open_time(user)))
    end
    
    result
  end
end
