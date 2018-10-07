shared_context 'finder' do
  let(:finder) { described_class.new(search_request) }
  let(:finder_with_invalid_search_request) do
    described_class.new(invalid_search_request)
  end
  let(:fields) { described_class::FIELDS }

  def search_process(finder)
    finder.visit_site
    finder.search_process
    yield if block_given?
  end

  def data_collection(finder)
    search_process(finder) { finder.data_collection }
  end
end

shared_examples '#visit_site' do
  it 'visits site successfully' do
    expect { finder.visit_site }.to_not raise_error
  end
end

shared_examples '#data_collection' do
  it 'returns searched data' do
    fields.all? do |field|
      data_collection(finder).any? do |item|
        expect(item[field]).to_not be_nil
      end
    end
  end

  it 'returns the empty array when search request is invalid' do
    expect(data_collection(finder_with_invalid_search_request)).to be_empty
  end
end
