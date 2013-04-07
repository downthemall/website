require 'model_spec_helper'

describe Category do

  describe "#all" do
    it "fetches categories from YAML" do
      cats = Category.all(dump_path('categories.yml'))
      expect(cats).to have(2).categories
      expect(cats.first.code).to eq('foo')
    end
  end

end

