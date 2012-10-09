# encoding: utf-8

Gem::Specification.new do |s|
  s.name = 'seo_paginate'
  s.version = '0.0.1'

  s.date = '2012-09-21'
  s.summary = 'Applies hard logic to pagination making your seo much better.'
  s.description = 'Search optimized pagination gem'
  s.authors = [ 'Daniel Milner', 'Aleksandr Kozhukhovskiy' ]
  s.email = 'akozhukhovskiy@partyearth.com'
  s.files = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.add_runtime_dependency(%q<will_paginate>, [">= 3.0.3"])
  s.add_development_dependency(%q<bundler>, ["~> 1.0.21"])

  # include only files in version control
  git_dir = File.expand_path('../.git', __FILE__)
  void = defined?(File::NULL) ? File::NULL :
    RbConfig::CONFIG['host_os'] =~ /msdos|mswin|djgpp|mingw/ ? 'NUL' : '/dev/null'

  if File.directory?(git_dir) and system "git --version >>#{void} 2>&1"
    s.files &= `git --git-dir='#{git_dir}' ls-files -z`.split("\0")
  end
end
