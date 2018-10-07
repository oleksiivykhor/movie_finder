require 'prawn'
require 'prawn/table'

class PDFConverter < BaseConverter
  FILE_FORMAT = 'pdf'

  def convert(data, file_path)
    content = document_content(data)
    Prawn::Document.generate(file_path) do
      table = make_table content, position: :center
      table.draw
      move_down 50
      text data[:copyright]
    end
  end

  private

  def document_content(data)
    content = [data[:fields].map { |f| f.to_s.capitalize }]
    data[:movies].each do |hash|
      content << data[:fields].map { |field| hash[field] }
    end
    content
  end
end
