module Infodeploy
  class SectionController < ApplicationController
    def managerment        
        @pages = Infodeploy::Page.find(params[:page_id])        
        @section = Section.where(:page_id=>params[:page_id])        
    end
    def new
        @sections=  Section.new
        @sections[:page_id] = params[:page_id]
        @sections[:number] = params[:number]
        @sections.save
        redirect_to :action => :managerment
    end
  end
end
