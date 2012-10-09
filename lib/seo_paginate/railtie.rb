module SeoPaginate
  class Railtie < Rails::Railtie
    initializer "seo_paginate" do |app|
      ActiveSupport.on_load :action_view do
        include SeoPaginate
      end
    end
  end
end
