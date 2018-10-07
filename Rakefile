require File.expand_path('../lib/movie_finder', __FILE__)
include Helpers

desc 'get movies list'
task :get_list, [:finder_name, :search_request, :format] do |t, args|
  format = args.format ? args.format : :csv
  m = MovieFinder.new(args.finder_name, args.search_request, format: format)
  m.get_list
  puts m.send(:results_file_path)
end

desc 'generate new product'
task :new, :name do |t, args|
  generator = get_class('product_generator').new(args.name)
  generator.generate
  puts "Created #{generator.lib_file_path}"
  puts "Created #{generator.spec_file_path}"
end
