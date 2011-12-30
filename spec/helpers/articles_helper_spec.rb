require 'spec_helper'

describe ArticlesHelper do

  describe ".replace_shortcodes" do
    before { @article = Factory(:article_with_image) }

    it "replaces image shortcodes with real paths" do
      helper.replace_shortcodes(@article, "!image:mozilla!").should == "!" + @article.images.first.image.url(:medium) + "!"
    end

    it "removes unknown shortcode references" do
      helper.replace_shortcodes(@article, "!image:nonexisting!").should be_blank
    end

  end

end
