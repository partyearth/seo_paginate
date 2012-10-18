RSpec::Matchers.define :show_pages do |*expected|
  match do |paginator|
    paginator.send(:windowed_page_numbers) == expected
  end

  description do
    "show pages: #{expected.join(', ')}"
  end

  failure_message_for_should do |paginator|
    "[#{paginator.send(:windowed_page_numbers).join(', ')}] - shown\n[#{expected.join(', ')}] - expected"
  end

  diffable
end

