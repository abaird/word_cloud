require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "WordCloud" do
  before(:all) do
    @wc = WordCloudinator.new("test_data.csv")
    good_result = <<-TEXT
bananas:3
pears:2
orange:1
    TEXT
  end
  it "should generate 3 bananas, 2 pears and 1 orange" do
    @wc.generate_text.should == good_result
  end

  it "should put the generated text in the wordle site" do
    @wc.dump_to_wordle
    @wc.browser.wordle_text.should == good_result
  end
end
