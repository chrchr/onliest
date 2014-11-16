Gem::Specification.new do |s|
  s.name        = 'Onliest'
  s.version     = '0.0.0'
  s.default_executable = 'onliest'
  s.date        = '2014-11-15'
  s.summary     = 'Onliest: generate unique values with numeric locality'
  s.description = 'Based on the method described by Zach Bloom at https://eager.io/blog/how-long-does-an-id-need-to-be/?hn'
  s.authors     = ['Robert Church']
  s.email       = 'chrchr@gmail.com'
  s.test_files = ["test/test_onliest.rb"]
  s.files       = ['lib/onliest.rb', 'bin/onliest']
  s.executables << 'onliest'
  s.homepage    = 'https://github.com/chrchr/onliest'
  s.license       = 'MIT'
end
