# -*- encoding : utf-8 -*-
module WouldPaginate
  module ViewHelpers
    # = URL generation for paginating
    # This class customize routes for paginate urls
    # and should be used for customizing pagination.
    class LinkRenderer < WillPaginate::ActionView::LinkRenderer
      protected

      def url(page)
        @base_url_params ||= begin
          url_params = merge_get_params(default_url_params)
          merge_optional_params(url_params)
        end

        url_params = @base_url_params.dup

        # TODO (AK) need to be changed, fast fix:
        "/#{@base_url_params[:city_id]}/festivals/all-annual/#{ "page-#{page}/" unless page==1 }"
        #@template.entertainers_directory_page_path(page)
      end
    end
  end
end
