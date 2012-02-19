class WordCloudinator
  attr_reader :use_color, :words, :data

  DarkBlue = "033155"
  LightBlue = "347FA9"
  Orange = "BB5D03"
  LightOrange = "D89E32"
  White = "F2F2F2"
  Yellow = "DAC113"
  Red = "780606"

  ColorPallet = [DarkBlue, LightBlue, Orange, LightOrange, White, Yellow, Red]

  BackGroundColor = "000000"

  Element = Struct.new(:name, :weight, :color)

  def initialize(file="data.yaml")
    @data = YAML::load_file(File.join(File.dirname(__FILE__), file))
    @use_color = data_has_color_values?
    @words = []
    data_to_words
  end

  def data_has_color_values?
    @data.each do |k, v|
      if v
        return false if v[0].is_a?(String)
        v.each do |ele|
          return true if ele.is_a?(Hash) && ele.has_key?("color")
        end
      end
    end
    return false
  end

  def pick_a_color
    num_colors = ColorPallet.length
    r = Random.new
    ColorPallet[r.rand(0..num_colors-1)]
  end

  def data_to_words
    @data.keys.each do |weight|
      words = @data[weight]
      if words
        words.each do |word|
          element = Element.new
          element.weight = weight.to_i
          if word.is_a?(Hash)
            element.name = word["name"]
            element.color = word["color"] == "none" ? pick_a_color : word["color"]
          else
            element.name = word
          end
          @words << element
        end
      end
    end
  end

  def generate_text
    str   = ''
    if @use_color
      @words.each { |word| str << "#{word.name}:#{word.weight}:#{word.color}\n" }
    else
      @words.each { |word| str << "#{word.name}:#{word.weight}\n" }
    end
    str
  end
end

class WordleBrowser
  attr_reader :browser

  def initialize(wc)
    @browser = Watir::Browser.new
    @browser.goto('http://www.wordle.net/advanced')
    @wc            = wc
    @specify_color = wc.use_color
  end

  def words_field
    @browser.text_field(:id, 'wordcounts');
  end

  def color_words_field
    @browser.text_field(:id, 'colorwordcounts');
  end

  def background_color
    @browser.text_field(:id, 'bg');
  end

  def dump_to_wordle
    if @specify_color
      color_words_field.value = @wc.generate_text
      background_color.value = WordCloudinator::BackGroundColor
    else
      words_field.value = @wc.generate_text
    end
    #sleep 5
    submit
  end

  def submit
    if @specify_color
      @browser.button(:class => 'submit', :index => 1).click
    else
      @browser.div(:id, 'controlpanel').element(:class => 'submit').click
    end
  end
end