# -*- encoding : utf-8 -*-
module SeoPaginate
  module ViewHelpers

    # Customizes routes for paginate urls.
    class LinkRenderer < WillPaginate::ActionView::LinkRenderer#WillPaginate::ViewHelpers::LinkRendererBase
      protected

      def windowed_page_numbers
        window_from = current_page / 10 * 10
        window_to = if total_pages > window_from + 10
                      window_from + 10 - 1
                    else
                      total_pages - 1
                    end
        window_from = 1 if window_from.zero?

        window = ( window_from .. window_to ).to_a

        last_hub_pages = (window_to + 1).step(total_pages, 10).to_a
        first_hub_pages = (window_from - 10).step(10, -10).to_a.reverse

        if current_page == 1 and total_pages == 1
          [1]
        elsif current_page < 10
          window + last_hub_pages.first(6) + [total_pages]
        else

          first_hub_size = last_hub_pages.size >= 3 ? 3 : 7 - last_hub_pages.size
          last_hub_size = first_hub_pages.size >= 3 ? 3 : 6 - first_hub_pages.size

          result = [1] + first_hub_pages.last(first_hub_size) + window + last_hub_pages.first(last_hub_size)

          if result.last == total_pages
            result
          else
            result + [total_pages]
          end
        end
      end

    # NOTE(AK): not used
    #  def hub_page?
    #    current_page == 1 || (current_page % 10).zero?
    #  end
    end
  end
end
