# -*- coding: utf-8 -*-
module Infodeploy
  class SlidesController < ApplicationController
  	def destroy_image
  	  Slide.find(params[:slide_id]).destroy
  	  render(:json => true.to_json,:layout => false)
  	end
  end
end
