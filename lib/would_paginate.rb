require 'will_paginate'
require 'will_paginate/view_helpers/link_renderer'
if defined?(Rails::Railtie)
  require 'would_paginate/railtie'
elsif defined?(Rails::Initializer)
  raise "would_paginate 0.0 is not compatible with Rails 2.3 or older"
end
require 'would_paginate/view_helpers/link_renderer'

module WouldPaginate
  def would_paginate collection, options = {}
    will_paginate collection, options.merge(:link_renderer => ::WouldPaginate::ViewHelpers::LinkRenderer)
  end
end
