class ProductGenerator < BaseGenerator
  def generate
    generate_file lib_file_path
    generate_file spec_file_path, 'spec'
  end
end
