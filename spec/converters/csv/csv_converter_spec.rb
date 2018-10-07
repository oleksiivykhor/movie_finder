require 'spec/converters/shared_examples'
require get_path_to_file('csv_converter')

describe CSVConverter do
  include_context 'converter'

  let(:data) do
    { fields: [:title, :genres, :year, :rating],
      copyright: 'Data provided by some site',
      movies: [{ title: 'Title', genres: 'Genre', year: '2018', rating: '8.0' },
        { title: 'Second Title', genres: 'Genre', year: '2018', rating: '9.0' }]
    }
  end
  let(:headers) { data[:fields].map { |f| f.to_s.capitalize } }
  let(:data_from_file) { CSV.read file_path }
  let(:compared_data) do
    data[:movies].all? do |movie|
      data_from_file.any? do |data|
        movie.values == data
      end
    end
  end

  it_behaves_like '#convert'

  it 'puts all data to the file' do
    expect(data_from_file.first).to eq headers
    expect(data_from_file.last).to eq [data[:copyright]]
    expect(compared_data).to be_truthy
  end
end
