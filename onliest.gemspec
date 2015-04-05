Gem::Specification.new do |s|
  s.name        = 'onliest'
  s.version     = '0.1.0'
  s.default_executable = 'onliest'
  s.date        = '2015-04-05'
  s.summary     = 'Onliest: generate unique values with numeric locality'
  s.description = 'Generate unique values with numeric locality.'
  s.authors     = ['Robert Church']
  s.email       = 'chrchr@gmail.com'
  s.test_files = ['test/test_onliest_default.rb', 'test/test_onliest_snowflake.rb']
  s.files       = ['lib/onliest.rb', 'lib/onliest/snowflake.rb', 'bin/onliest']
  s.executables << 'onliest'
  s.homepage    = 'https://github.com/chrchr/onliest'
  s.license       = 'MIT'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
end
