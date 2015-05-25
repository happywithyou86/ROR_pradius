module ActionView
  module Helpers

    # ....

    module DateHelper
      def time_ago_in_words(from_time, include_seconds = false)
        distance_of_time_in_words(from_time, Time.now, include_seconds)
      end
  end
end
end