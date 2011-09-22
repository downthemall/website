class Article < ActiveRecord::Base
  has_ancestry :orphan_strategy => :restrict, :cache_depth => true
  has_many :translations, :class_name => "ArticleTranslation", :dependent => :destroy
end
