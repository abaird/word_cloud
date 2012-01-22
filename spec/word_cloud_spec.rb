require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "WordCloud" do
  before(:all) do
    @wc = WordCloudinator.new("test_data.yaml")
    @good_result = <<-TEXT
bananas:3
oranges:2
pears:1
    TEXT
  end
  it "should generate 3 bananas, 2 pears and 1 orange" do
    @wc.generate_text.should == @good_result
  end

  it "should put the generated text in the wordle site" do
    wb = WordleBrowser.new(@wc)
    wb.dump_to_wordle
    wb.browser.url.should == "http://www.wordle.net/compose"
  end
end
