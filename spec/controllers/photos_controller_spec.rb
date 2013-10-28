require 'spec_helper'

describe PhotosController do
  describe "POST upload multiple" do
    it "should save multiple files" do
      @photo1 = mock_model(Photo)
      @photo2 = mock_model(Photo)
      @photo3 = mock_model(Photo)
      post :make_multiple, :photo => {:images => {@photo1, @photo2, @photo3}}
      #test stuff
    end
    it "should redirect if no files" do
    end
  end
end