require 'spec_helper'

describe ArticlesController do

  context ".index" do
    it "should provide @sticky_articles" do
      get 'index'
      assigns[:sticky_articles].should_not be_nil
    end
  end
end
