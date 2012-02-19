class WordCloudinator
  attr_reader :use_color, :words, :data

  DarkBlue_dk = "032C4C"
  DarkBlue    = "033155"
  DarkBlue_lt = "1C4666"

  DarkGreen_dk = "005C00"
  DarkGreen    = "006600"
  DarkGreen_lt = "197519"

  LightBlue_dk = "2F7298"
  LightBlue    = "347FA9"
  LightBlue_lt = "488CB2"

  Orange_dk = "A85403"
  Orange    = "BB5D03"
  Orange_lt = "BB5D03"

  LightOrange_dk = "D89E32"
  LightOrange    = "D89E32"
  LightOrange_lt = "C26D1C"

  White_dk = "DADADA"
  White    = "F2F2F2"
  White_lt = "F3F3F3"

  Yellow_dk = "C4AE11"
  Yellow    = "DAC113"
  Yellow_lt = "DEC72B"

  Red_dk = "6C0505"
  Red    = "780606"
  Red_lt = "861F1F"

  ColorPallet             = [DarkBlue, LightBlue, Orange, LightOrange, White, Yellow, Red]
  ColorPalletComplex      = [DarkBlue, LightBlue, Orange, LightOrange, White, Yellow, Red,
                             LightBlue_dk, Orange_dk, LightOrange_dk, White_dk, Yellow_dk, Red_dk,
                             DarkBlue_lt, LightBlue_lt, Orange_lt, LightOrange_lt, White_lt, Yellow_lt, Red_lt]
  ColorPalletGreenComplex = [DarkGreen, LightBlue, Orange, LightOrange, White, Yellow, Red,
                             DarkGreen_dk, LightBlue_dk, Orange_dk, LightOrange_dk, White_dk, Yellow_dk, Red_dk,
                             DarkGreen_lt, LightBlue_lt, Orange_lt, LightOrange_lt, White_lt, Yellow_lt, Red_lt]

  BackGroundColor = "000000"

  Element = Struct.new(:name, :weight, :color)

  def initialize(file="data.yaml")
    @data      = YAML::load_file(File.join(File.dirname(__FILE__), file))
    @use_color = data_has_color_values?
    @words     = []
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
    num_colors = ColorPalletGreenComplex.length
    r          = Random.new
    ColorPalletGreenComplex[r.rand(0..num_colors-1)]
  end

  def data_to_words
    @data.keys.each do |weight|
      words = @data[weight]
      if words
        words.each do |word|
          element        = Element.new
          element.weight = weight.to_i
          if word.is_a?(Hash)
            element.name  = word["name"]
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
    str = ''
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
      background_color.value  = WordCloudinator::BackGroundColor
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