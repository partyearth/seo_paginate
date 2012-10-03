# encoding: utf-8
require 'rbconfig'
require File.expand_path('../lib/would_paginate/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'would_paginate'
  s.version = WouldPaginate::VERSION::STRING

  s.date = '2012-09-21'
  s.summary = 'A pagination solution'
  s.description = 'Search optimized pagination gem'
  s.authors = [ 'Daniel Milner', 'Aleksandr Kozhukhovskiy' ]
  s.email = 'akozhukhovskiy@partyearth.com'
  s.files = Dir[ '{bin,lib,test,spec}/**/*', 'README*', 'LICENSE*']

  # include only files in version control
  git_dir = File.expand_path('../.git', __FILE__)
  void = defined?(File::NULL) ? File::NULL :
    RbConfig::CONFIG['host_os'] =~ /msdos|mswin|djgpp|mingw/ ? 'NUL' : '/dev/null'

  if File.directory?(git_dir) and system "git --version >>#{void} 2>&1"
    s.files &= `git --git-dir='#{git_dir}' ls-files -z`.split("\0")
  end
end
