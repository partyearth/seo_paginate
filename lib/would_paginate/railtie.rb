require 'would_paginate'

module WouldPaginate
  class Railtie < Rails::Railtie
    initializer "would_paginate" do |app|

      ActiveSupport.on_load :action_view do
        require 'would_paginate/view_helpers/action_view'
      end

      #self.class.add_locale_path config

      # early access to ViewHelpers.pagination_options
      #require 'would_paginate/view_helpers'
    end

  end
end
