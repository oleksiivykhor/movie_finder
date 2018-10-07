require 'spec/converters/shared_examples'
require get_path_to_file('pdf_converter')
require 'pdf-reader'

describe PDFConverter do
  include_context 'converter'

  let(:data) do
    { fields: [:title, :genres, :year, :rating],
      copyright: 'Data provided by some site',
      movies: [{ title: 'Title', genres: 'Genre', year: '2018', rating: '8.0' },
        { title: 'Second Title', genres: 'Genre', year: '2018', rating: '9.0' }]
    }
  end
  let(:pdf_text) { PDF::Reader.new(file_path).pages.map(&:text).join }

  it_behaves_like '#convert'

  it 'puts all data to the file' do
    expect(pdf_text[data[:copyright]]).not_to be_nil
    data[:fields].each do |field|
      field = field.to_s.capitalize
      expect(pdf_text[field]).not_to be_nil
    end

    data[:movies].each do |movie|
      movie.values.each do |val|
        expect(pdf_text[val]).not_to be_nil
      end
    end
  end
end
