class WordCloudinator
  attr_reader :color

  def initialize(file="data.csv", color=:random)
    @words = words_to_hash(FasterCSV.read(File.join(File.dirname(__FILE__), file)))
    @color = color
  end

  def words_to_hash(data)
    words = {}
    data.each do |row|
      words[row[0]] = row[1].to_i
    end
    words
  end

  def generate_text
    str = ''
    words = @words.keys.sort
    words.each { |word| str << "#{word}:#{@words[word]}\n" }
    str
  end
end

class WordleBrowser
  attr_reader :browser
  def initialize(wc)
    @browser = Watir::Browser.new
    @browser.goto('http://www.wordle.net/advanced')
    @wc = wc
    @specify_color = wc.color == :random ? false : true
  end

  def words_field; @browser.text_field(:id, 'wordcounts'); end
  def color_words_field; @browser.text_field(:id, 'colorwordcounts'); end
  def background_color; @browser.text_field(:id, 'bg'); end

  def dump_to_wordle
    if @specify_color
      color_words_field.value = @wc.generate_text
    else
      words_field.value = @wc.generate_text
    end
    submit
  end

  def submit
    if @specify_color
      @browser.button(:class => 'submit', :index => 1).click
    else
      @browser.div(:id, 'controlpanel').element(:class=>'submit').click
    end
  end
end