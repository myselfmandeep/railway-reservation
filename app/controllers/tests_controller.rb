class TestsController < ApplicationController

  def new
  end

  def create
  end

  def show
    respond_to do |format|
      format.js
    end
  end
  
end
