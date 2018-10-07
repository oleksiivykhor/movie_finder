module Helpers
  private

  def get_class(class_name, upper = false, attempts = 1)
    require get_path_to_file(class_name)

    kase = upper ? :upcase : :capitalize
    parts = class_name.split('_')
    last_part = parts.pop.capitalize
    parts.map! { |part| part.public_send(kase) }
    cls_name = "#{parts.join}#{last_part}"
    raise NameError unless Object.const_defined? cls_name

    Object.const_get(cls_name)
  rescue NameError
    raise "Class is undefined for: #{class_name}" if attempts.zero?

    get_class(class_name, true, attempts - 1)
  end

  def get_class_dir_name(class_name)
    parts = class_name.split(/(?=[A-Z][^A-Z])/)
    parts.pop
    parts.map do |part|
      part.downcase
    end.join('_')
  end

  def get_path_to_file(file_name, source = 'lib')
    parts = file_name.split('_')
    base_dir_name = "#{parts.pop}s"
    product_dir_name = parts.join('_')
    file_name = source.eql?('spec') ? "#{file_name}_spec" : file_name
    File.join(
      ENV['HOME'],
      "#{source}/#{base_dir_name}/#{product_dir_name}/#{file_name}"
    )
  end

  def create_dir(dir_path)
    FileUtils.mkdir_p dir_path
  end

  def create_file(file_path)
    dir_path = file_path.split('/')[0..-2].join('/')
    create_dir dir_path
    FileUtils.touch file_path
  end
end
