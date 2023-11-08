class PagesController < ApplicationController
  def index
  end

  def thread_one
    binding.irb if Rails.env.test?
    render plain: 'This is plain text'
  end

  def thread_two
    binding.irb if Rails.env.test?
    render plain: 'This is plain text'
  end
end
