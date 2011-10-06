require 'spec_helper'

describe Comment do

  it "throws a validation error if the comment has neither an user_id or a author informations" do
    @comment = Comment.new
    @comment.should_not be_valid
    @comment.errors[:base].should include I18n.t("activerecord.errors.models.comment.no_name_or_author_infos")
  end

end
