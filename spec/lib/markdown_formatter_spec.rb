# encoding: utf-8

require "spec_helper"

describe MarkdownFormatter do

  describe "#format" do
    it "uses smarty pants extension" do
      expect(MarkdownFormatter.format("Foo --- bar")).to eq "<p>Foo — bar</p>"
    end
    it "wraps <img/> elements in <figure/>s" do
      expect(MarkdownFormatter.format("![Alt text](img.jpg)")).to eq '<p><figure><img src="img.jpg" alt="Alt text"><figcaption>Alt text</figcaption></figure></p>'
    end
    it "adds fenced !!! syntax to create aside notes" do
      expect(MarkdownFormatter.format("!!!\nFoo\n!!!")).to eq "<aside><p>Foo</p>\n</aside>"
    end
    it "filters <script/> tags" do
      expect(MarkdownFormatter.format("foo<script>foo bar</script>")).to eq "<p>foofoo bar</p>"
    end
  end

end

