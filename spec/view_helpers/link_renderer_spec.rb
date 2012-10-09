require 'spec_helper'

describe WouldPaginate::ViewHelpers::LinkRenderer do

  shared_examples_for "will paginate" do

    it "raises error when unprepared" do
      lambda { subject.pagination }.should raise_error
    end

    describe "#current_page" do
      before { prepare({}) }
      its(:current_page) { should == 1 }
    end

    describe "#total_pages" do
      before { prepare :total_pages => 42 }
      its(:total_pages) { should == 42 }
    end

    describe "#pagination" do
      before do
        prepare({ :total_pages => 1 }, :page_links => true)
      end

      its(:pagination) { should == [:previous_page, 1, :next_page] }
    end
  end

  it_behaves_like "will paginate"

  describe "visible page numbers" do
    context "hub pages" do
      let(:total_pages){ 182 }
      before { prepare( { page: page, total_pages: total_pages } ) }

      context "page 1" do
        let(:page){ 1 }
        it { should show_pages 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 60, 182 }
      end

      context "page 10" do
        let(:page) { 10 }
        it { should show_pages 1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 30, 40, 50, 60, 70, 182 }
      end

      context "page 30" do
        let(:page) { 30 }
        it { should show_pages 1, 10, 20, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 50, 60, 70, 182 }
      end

      context "page 120" do
        let(:page){ 120 }
        it { should show_pages 1, 90, 100, 110, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 140, 150, 182 }
      end

      context "page 180" do
        let(:page) { 180 }
        it { should show_pages 1, 120, 130, 140, 150, 160, 170, 180, 181, 182 }
      end
    end

    context "non-hub pages" do
      let(:total_pages){ 182 }
      before { prepare( { page: page, total_pages: total_pages } ) }

      context "page 3" do
        let(:page){ 3 }
        it{ should show_pages 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 60, 182 }
      end

      context "page 15" do
        let(:page) { 15 }
        it{ should show_pages 1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 30, 40, 50, 60, 70, 182 }
      end

      context "page 37" do
        let(:page) { 37 }
        it{ should show_pages 1, 10, 20, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 50, 60, 70, 182 }
      end

      context "page 128" do
        let(:page){ 128 }
        it{ should show_pages 1, 90, 100, 110, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 140, 150, 182 }
      end

      context "page 181" do
        let(:page) { 181 }
        it{ should show_pages 1, 120, 130, 140, 150, 160, 170, 180, 181, 182 }
      end
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
      subject.prepare(collection(collection_options), options, 'template')
    end
end
