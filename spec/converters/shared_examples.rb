shared_context 'converter' do
  let(:converter) { described_class.new }
  let(:dir_name) { get_class_dir_name(converter.class.name) }
  let(:file_format) { converter.class::FILE_FORMAT }
  let(:file_path) do
    File.join(
      ENV['HOME'],
      "spec/fixtures/converters/#{dir_name}/results.#{file_format}"
    )
  end
end

shared_examples '#convert' do
  it 'converts data to desired format' do
    expect { converter.convert(data, file_path) }.to_not raise_error
  end
end
