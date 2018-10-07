class BaseGenerator
  include Helpers

  attr_reader :lib_file_path, :spec_file_path

  def initialize(name)
    parts = name.split('_')
    @name = name
    @class_name = parts.map(&:capitalize).join
    @product = parts.last
    @lib_file_path = "#{get_path_to_file(name)}.rb"
    @spec_file_path = "#{get_path_to_file(name, 'spec')}.rb"
  end

  def generate
    raise NotImplementedError
  end

  private

  def get_template(source)
    product_dir_name = get_class_dir_name(self.class.name)
    path = File.join(
      ENV['HOME'],
      "lib/templates/#{product_dir_name}/#{source}/#{@product}.erb"
    )
    ERB.new(File.read(path)).result(binding)
  end

  def generate_file(file_path, source = 'lib')
    create_file file_path
    File.open(file_path, 'w') do |file|
      file.write get_template source
    end
  end
end
