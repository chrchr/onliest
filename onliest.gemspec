Gem::Specification.new do |s|
  s.name        = 'onliest'
  s.version     = '0.0.2'
  s.default_executable = 'onliest'
  s.date        = '2014-11-15'
  s.summary     = 'Onliest: generate unique values with numeric locality'
  s.description = 'Generate unique values with numeric locality.'
  s.authors     = ['Robert Church']
  s.email       = 'chrchr@gmail.com'
  s.test_files = ['test/test_onliest.rb']
  s.files       = ['lib/onliest.rb', 'bin/onliest']
  s.executables << 'onliest'
  s.homepage    = 'https://github.com/chrchr/onliest'
  s.license       = 'MIT'
end
