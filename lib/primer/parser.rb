class Parser
  def self.parse! filename
    entries = File.read(File.open(filename)).split("\n").inject({}) do |memo, line|
      key, value = line.split('=')
      option = process_option(key, line)
      memo[option[0]] = option[1]
      memo
    end

    entries
  end

  private
  def self.process_option(key, option)
    case key
    when "-s"
    when "--services"
      [:services, option.split(",").map{|dir| dir.strip}]
    end
  end
end