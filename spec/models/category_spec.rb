require 'model_spec_helper'

describe Category do

  describe "#all" do
    it "fetches categories from YAML" do
      cats = Category.all(dump_path('categories.yml'))
      cats.should have(2).categories
      cats.first.code.should == 'foo'
    end
  end

end
