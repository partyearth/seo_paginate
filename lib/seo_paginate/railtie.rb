module WouldPaginate
  class Railtie < Rails::Railtie
    initializer "would_paginate" do |app|
      ActiveSupport.on_load :action_view do
        include WouldPaginate
      end
    end
  end
end
