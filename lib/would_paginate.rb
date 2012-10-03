# You would paginate!
module WouldPaginate
end

=begin
if defined?(Rails::Railtie)
  require 'would_paginate/railtie'
elsif defined?(Rails::Initializer)
  raise "would_paginate 0.0 is not compatible with Rails 2.3 or older"
end
=end
