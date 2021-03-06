Gem::Specification.new do |s|
  s.name        = 'thinking_lobster'
  s.version     = '1.0.3'
  s.summary     = 'A leitner based spaced repetition system algorithm for MongoDB.'
  s.date        = '2013-10-21'
  s.description = 'Automatically schedules review times for learning material stored in a mongoDB database by way of a spaced repetition algorithm. Resembles the Leitner Method.'
  s.authors     = ['Rick Carlino']
  s.license     = 'MIT'
  s.email       = 'please-use-github@rickcarlino.com'
  s.homepage    = 'https://github.com/rickcarlino/Thinking-Lobster'
  s.files       = ['lib/thinking_lobster.rb']

  s.add_runtime_dependency 'bson_ext'
  s.add_runtime_dependency 'mongo'
  s.add_runtime_dependency 'mongoid'
end