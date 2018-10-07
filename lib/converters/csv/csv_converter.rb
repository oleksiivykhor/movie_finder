require 'csv'

class CSVConverter < BaseConverter
  FILE_FORMAT = 'csv'

  def convert(data, file_path)
    content = document_content(data)
    CSV.open(
      file_path, 'w',
      write_headers: true,
      headers: data[:fields].map(&:capitalize)
    ) do |csv|
      content.each { |c| csv << c }
      csv << []
      csv << [data[:copyright]]
    end
  end

  private

  def document_content(data)
    data[:movies].map do |hash|
      data[:fields].map { |field| hash[field] }
    end
  end
end
