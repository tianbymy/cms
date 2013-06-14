module Infodeploy
  class PortletController < ApplicationController
    before_filter :get_portlets, :only => [:edit,:update,:destroy]
    before_filter :get_by_portlet_id, :only => [:move_portlet_top,:move_portlet_bottom]
    def index
      @portlets = Portlet.all
    end

    def edit
      if Integer(@portlets[:type])==3
        @ads=Ads.find(@portlets[:option]["ads_id"])
      end
    end
    
    def new
      @portlets = Portlet.new
    end

    def create
      @portlets = Portlet.new(params[:portlets])
      @portlets[:page_id] = params[:page_id]
      @portlets[:section_id] = params[:section_id]      
      if @portlets[:type]==3
        @ads=Ads.new(:number => Ads.count+1,:size=>@portlets[:option]["size"])
        @ads.save
        @portlets[:option]["ads_id"]=@ads.id
      end
      if @portlets.save
        redirect_to "/infodeploy/page/"+params[:page_id]+"/section/managerment"
      else
        render "new"
      end      
    end

    def update
      if @portlets[:type]==3
        params[:portlets][:option]["ads_id"]=@portlets[:option]["ads_id"]
        @ads=Ads.find(@portlets[:option]["ads_id"])
        @ads.update_attribute(:size,params[:portlets][:option]["size"])
      end
      if @portlets.update_attributes(params[:portlets])
        redirect_to "/infodeploy/page/"+params[:page_id]+"/section/managerment"
      else
        render "edit"
      end
    end
     def destroy
      if @portlets[:type]==3
        @ads=Ads.find(@portlets[:option]["ads_id"])
        @ads.destroy
      end
      @portlets.destroy
      redirect_to "/infodeploy/page/"+params[:page_id]+"/section/managerment"
    end

     
    def move_portlet_top
      @portlets[:number] = @portlets[:number]-1
      @portlets.update_attribute(:number,@portlets[:number])
      redirect_to "/infodeploy/page/"+params[:page_id]+"/section/managerment"
    end
    
    def move_portlet_bottom 
      @portlets[:number] = @portlets[:number]+1
      @portlets.update_attribute(:number,@portlets[:number])
      redirect_to "/infodeploy/page/"+params[:page_id]+"/section/managerment"
    end

    private
    def get_portlets
      @portlets = Portlet.find(params[:id])
    end

    def get_by_portlet_id
      @portlets = Portlet.find(params[:portlet_id])
    end
  end
end
