require 'spec_helper'
require 'will_paginate/view_helpers/link_renderer'
require 'would_paginate/view_helpers/link_renderer'

describe WouldPaginate::ViewHelpers::LinkRenderer do

  before do
    @renderer = described_class.new
  end

  it "should raise error when unprepared" do
    lambda {
      @renderer.pagination
    }.should raise_error
  end

  it "should prepare with collection and options" do
    prepare({}, 'template')
    @renderer.send(:current_page).should == 1
  end

  it "should have total_pages accessor" do
    prepare :total_pages => 42
    @renderer.send(:total_pages).should == 42
  end

  it "should clear old cached values when prepared" do
    prepare(:total_pages => 1)
    @renderer.send(:total_pages).should == 1
    # prepare with different object:
    prepare(:total_pages => 2)
    @renderer.send(:total_pages).should == 2
  end

  it "should have pagination definition" do
    prepare({ :total_pages => 1 }, :page_links => true)
    @renderer.pagination.should == [:previous_page, 1, :next_page]
  end

  describe "visible page numbers" do
    context "hub pages" do
      let(:total_pages){ 182 }
      before { prepare( { page: page, total_pages: total_pages } ) }

      context "page 1" do
        let(:page){ 1 }
        it{ showing_pages 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 60, 182 }
      end

      context "page 10" do
        let(:page) { 10 }
        it{ showing_pages 1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 30, 40, 50, 60, 70, 182 }
      end

      context "page 30" do
        let(:page) { 30 }
        it{ showing_pages 1, 10, 20, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 50, 60, 70, 182 }
      end

      context "page 120" do
        let(:page){ 120 }
        it{ showing_pages 1, 90, 100, 110, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 140, 150, 182 }
      end

      context "page 180" do
        let(:page) { 180 }
        it{ showing_pages 1, 120, 130, 140, 150, 160, 170, 180, 181, 182 }
      end
    end

    context "non-hub pages" do
      let(:total_pages){ 182 }
      before { prepare( { page: page, total_pages: total_pages } ) }

      context "page 3" do
        let(:page){ 3 }
        it{ showing_pages 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 60, 182 }
      end

      context "page 15" do
        let(:page) { 15 }
        it{ showing_pages 1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 30, 40, 50, 60, 70, 182 }
      end

      context "page 37" do
        let(:page) { 37 }
        it{ showing_pages 1, 10, 20, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 50, 60, 70, 182 }
      end

      context "page 128" do
        let(:page){ 128 }
        it{ showing_pages 1, 90, 100, 110, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 140, 150, 182 }
      end

      context "page 181" do
        let(:page) { 181 }
        it{ showing_pages 1, 120, 130, 140, 150, 160, 170, 180, 181, 182 }
      end
    end

    def showing_pages(*pages)
      pages = pages.first.to_a if Array === pages.first or Range === pages.first
      @renderer.send(:windowed_page_numbers).should == pages
    end
  end

  protected

    def collection(params = {})
      if params[:total_pages]
        params[:per_page] = 1
        params[:total_entries] = params[:total_pages]
      end
      WillPaginate::Collection.new(params[:page] || 1, params[:per_page] || 30, params[:total_entries])
    end

    def prepare(collection_options, options = {})
      @renderer.prepare(collection(collection_options), options, 'template')
    end

end
