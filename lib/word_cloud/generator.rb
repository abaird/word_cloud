class WordCloudinator
  def initialize(file="data.csv")
    @words = {}
    @browser = WordleBrowser.new
  end

  def generate_text
    
  end
end

class WordleBrowser
  def initialize
    @browser = Watir::Browser.new
    @browser.goto('http://wordle.net')
  end
end