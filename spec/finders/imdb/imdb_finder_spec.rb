require 'spec/finders/shared_examples'
require get_path_to_file('imdb_finder')

describe IMDBFinder do
  include_context 'finder'

  let(:search_request) { 'pro evolution soccer' }
  let(:invalid_search_request) { 'invalid search request' }

  it_behaves_like '#visit_site'
  it_behaves_like '#data_collection'

  context 'when #find raises Capybara::ElementNotFound' do
    before do
      allow(finder).to receive(:find).and_raise Capybara::ElementNotFound
    end

    it 'returns nil' do
      expect(finder.send(:find_or_nil, "//some_path")).to be_nil
    end
  end

  context 'when #first raises Capybara::ExpectationNotMet' do
    before do
      allow(finder).to receive(:first).and_raise Capybara::ExpectationNotMet
    end

    it 'returns nil' do
      expect(finder.send(:find_or_nil, "//some_path", first: true)).to be_nil
    end
  end
end
