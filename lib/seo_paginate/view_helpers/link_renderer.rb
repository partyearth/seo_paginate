# -*- encoding : utf-8 -*-
module SeoPaginate
  module ViewHelpers

    # Customizes routes for paginate urls.
    class LinkRenderer < WillPaginate::ActionView::LinkRenderer#WillPaginate::ViewHelpers::LinkRendererBase

      protected

      def previous_or_next_page(page, text, classname)
        if page
          #link(text, page, :class => classname)
          tag(:span, text, :class => classname + ' GooglizedLink', 'data-link' => url(page))
        else
          tag(:span, text, :class => classname + ' disabled')
        end
      end

      def page_number(page)
        if page == current_page
          tag(:em, page, class: 'current')
        else
          if hub_page? or (page == 1 and current_page != 1) or ( page == (current_page / 10 * 10 + 10 ))
            link(page, page, :rel => rel_value(page))
          else
            tag(:span, page, :class => "GooglizedLink", 'data-link' => url(page) )
          end
        end
      end

      # Insert gaps when it is required
      #
      # @param <Array> page_numbers array of page numbers
      #
      # @return <Array> array of pages with inserted gaps
      def gapify page_numbers
        page_numbers.inject([]) do |arr, v|
          if arr.last.nil?
            [v]
          elsif arr.last + 1 == v
            arr + [v]
          else
            arr + [:gap] + [v]
          end
        end
      end

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

        result = if current_page == 1 and total_pages == 1
          [1]
        elsif current_page < 10
          window + last_hub_pages.first(6)
        else

          first_hub_size = last_hub_pages.size >= 3 ? 3 : 7 - last_hub_pages.size
          last_hub_size = first_hub_pages.size >= 3 ? 3 : 6 - first_hub_pages.size

          [1] + first_hub_pages.last(first_hub_size) + window + last_hub_pages.first(last_hub_size)
        end

        if result.last == total_pages
          gapify result
        else
          gapify result + [total_pages]
        end
      end

      def hub_page?
        current_page == 1 || (current_page % 10).zero?
      end
    end
  end
end
