Thinking Lobster (1.0.0 Alpha Release)
[![Gem Version](https://badge.fury.io/rb/thinking_lobster.png)](http://badge.fury.io/rb/thinking_lobster) [![Code Climate](https://codeclimate.com/github/rickcarlino/Thinking-Lobster.png)](https://codeclimate.com/github/rickcarlino/Thinking-Lobster)


A Ruby gem to add [spaced repetion](http://en.wikipedia.org/wiki/Spaced_repetition) functionality to [Mongoid](http://mongoid.org/) documents.

This gem is used for non-scaled, correct / incorrect review systems only. In that sense, it is more similar to the [Leitner System](http://en.wikipedia.org/wiki/Leitner_system) than scaled response algorithms, such as [SM Family of algorithms](http://www.supermemo.com/english/ol/sm2.htm).

I need feedback
---
This gem is still undergoing human testing. If you use this gem and have comments about the default intervals or questions about using it, please submit an issue.

Examples
---

**If you need extensive help, please see the [documentation](http://rickcarlino.github.io/Thinking-Lobster/)**

```ruby
#after setting up mongoid and requiring ThinkingLobster
class FlashCard
  include Mongoid::Document
  include ThinkingLobster

  field :question
  field :answer

end

q = FlashCard.create(question: 'First American President', answer: 'George Washington')

q.review_time
# => 2013-10-19 22:06:28 -0700

# Marks the item correct and automatically lengthens the time until next review.
q.mark_correct!
# => #<FlashCard 0x123>

# Marking it wrong will intelligently shorten the time until next review.
q.mark_incorrect!
# => #<FlashCard 0x123>

q.previous_review?
#returns instance of Time
# => 2013-10-19 22:06:28 -0700

q.time_since_due
#Returns number of seconds since it was due
# => 2335243423

# The point of using an SRS is reviewing LESS, not more.
# This method lets you know if its not time to review yet...
q.too_soon?
# => true

#When things go wrong...
q.reset
q.save
# Resets all learning data for a particular item.

# A bunch of configurations...
ThinkingLobster.config
# => {:cutoff=>129600, :first_interval=>7200, :new_positive_multiplier=>2.0, :old_positive_multiplier=>1.25, :penalty=>0.25}

# If you know what you are doing, you can change them like this...
ThinkingLobster.config.merge!(penalty: 0.5)
# => {:cutoff=>129600, :first_interval=>7200, :new_positive_multiplier=>2.0, :old_positive_multiplier=>1.25, :penalty=>0.5}
# Don't do that unless you have a reason to, though.

```

Installation
---

```
gem install thinking_lobster
```

or with bundler via

```gem 'thinking_lobster'```

Testing and Development
---

```rake test```

Generate [documentation](http://rickcarlino.github.io/Thinking-Lobster/) with Sdoc.

```sdoc lib/```

License
---

Licensed under the MIT License. See license.txt for more information.

Contributors
---
 * Rick Carlino
 * Brett Byler

Please add your name to this list if submitting a pull request.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/rickcarlino/thinking-lobster/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

