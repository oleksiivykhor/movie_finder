require File.expand_path('../dependencies', __FILE__)

class MovieFinder
  include Helpers

  attr_reader :finder, :converter

  def initialize(finder_name, search_request, format: :csv)
    @logger = MovieFinderLogger.new('movie_finder')
    @finder = get_class("#{finder_name}_finder").new(search_request)
    @converter = get_class("#{format}_converter").new
  end

  def get_list
    create_file(results_file_path)
    finder.visit_site
    finder.search_process
    converter.convert(finder.data, results_file_path)
    @logger.log.info "Getting movies list #{results_file_path}"
  end

  private :finder, :converter

  private

  def results_file_path
    current_date_time = DateTime.now
    current_date_time_str = current_date_time.strftime('%d_%m_%Y_%H_%M_%S')
    dir_path = "tmp/#{finder.class}/#{current_date_time_str}"
    @path ||= File.join(ENV['HOME'], "#{dir_path}/results.#{converter.class::FILE_FORMAT}")
  end
end
