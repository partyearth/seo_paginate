require 'action_view'
require 'will_paginate'
require 'will_paginate/view_helpers/action_view'
if defined?(Rails::Railtie)
  require 'seo_paginate/railtie'
elsif defined?(Rails::Initializer)
  raise "seo_paginate 0.0 is not compatible with Rails 2.3 or older"
end
require 'seo_paginate/view_helpers/link_renderer'

module SeoPaginate
  def seo_paginate collection, options = {}
    will_paginate collection, options.merge(renderer: ::SeoPaginate::ViewHelpers::LinkRenderer)
  end
end
