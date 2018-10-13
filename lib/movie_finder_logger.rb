class MovieFinderLogger
  def initialize(log_name)
    @log_name = log_name
  end

  def log
    if @logger.nil?
      path = File.join(ENV['HOME'], "logs/#{@log_name}.log")
      create_file path
      @logger = Logger.new path
      @logger.level = Logger::DEBUG
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S '
    end
    @logger
  end
end
