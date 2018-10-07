require get_path_to_file('product_generator')

describe ProductGenerator do
  let(:generator) { described_class.new('test_finder') }
  let(:lib_file_path) do
    File.join(ENV['HOME'], 'spec/fixtures/generators/product/lib/test_finder')
  end
  let(:spec_file_path) do
    File.join(ENV['HOME'], 'spec/fixtures/generators/product/spec/test_finder_spec')
  end

  def delete_files
    [lib_file_path, spec_file_path].each do |path|
      File.delete path if File.exist? path
    end
  end

  before do
    allow(generator).to receive(:lib_file_path).and_return(lib_file_path)
    allow(generator).to receive(:spec_file_path).and_return(spec_file_path)
  end

  around do |example|
    delete_files
    example.call
    delete_files
  end

  it 'generates lib and spec files' do
    generator.generate
    expect(File.exist?(lib_file_path)).to be_truthy
    expect(File.exist?(spec_file_path)).to be_truthy
  end
end
