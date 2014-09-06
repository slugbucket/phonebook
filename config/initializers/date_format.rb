Date::DATE_FORMATS.merge!(
  :my_date => lambda { |time| time.strftime("#{ActiveSupport::Inflector.ordinalize(time.day)} %b %Y") })
# The above won't work with datetime columns, so use the following
Time::DATE_FORMATS.merge!(:time2date => lambda { |time| time.strftime("#{ActiveSupport::Inflector.ordinalize(time.day)} %b %Y") })