class StartPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[top privacy terms]
  def top; end

  def privacy; end

  def terms; end
end
