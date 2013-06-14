# -*- coding: utf-8 -*-
module Infodeploy
  class ProgramasController < ApplicationController
    before_filter :get_channel,:except => [:get_by_kinds]
    before_filter :get_programa,:only => [:edit,:update,:destroy]
    def new
      @programa = Programa.new
    end

    def create
      @programa = Programa.new(params[:programa])
      @programa[:createuser]=session[:cas_user]
      @programa[:modifyuser]=session[:cas_user]
      @programa.channel_id=@channel.id
      @programa[:kinds]=get_kinds(params[:kinds])
      if @programa.save
        redirect_to create_agin_check
      else
        render "new"
      end
    end

    def update
      @programa[:modifyuser]=session[:cas_user]
      @programa[:kinds]=get_kinds(params[:kinds])
      if @programa.update_attributes(params[:programa])
        flash[:programa_info]="栏目更新成功"
        redirect_to :action => :index
      else
        render "edit"
      end
    end

    def destroy
      set_destroy_message
      if Article.where(:programa_id => @programa.id.to_s).size == 0
        @programa.destroy
      end
      redirect_to :action => :index
    end

    def get_by_channel
      channel=Channel.find(params[:channel_id])
      programas=Programa.where(:channel_id => channel.id,:enabled => 0).to_json
      render(:json => programas,:layout => false)
    end

    def get_all_by_channel
      channel=Channel.find(params[:channel_id])
      programas=([Infodeploy::Programa.new(:name => "---请选择---",:id => "")]+Programa.where(:channel_id => channel.id,:enabled => 0)).to_json
      render(:json => programas,:layout => false)
    end

    def get_by_kinds
     programa=Programa.find(params[:programa_id])
     render(:json => get_kinds_array(programa.kinds),:layout => false)
    end

    private
    def create_agin_check
      return {:action => :index} if params[:agin] == nil
      flash[:programa_info]="栏目创建成功"
      {:action => :new,:channel_id => @channel.id}
    end

    def set_destroy_message
      return "栏目:"+@programa.name+" 删除成功" if Article.where(:programa_id => @programa.id.to_s).size == 0
      "栏目:"+@programa.name+" 删除失败,原因:该栏目下已存在文章"
    end

    def get_programa
      @programa = Programa.find(params[:id])
    end

    def get_channel
      @channel=Channel.find(params[:channel_id])
    end

    def get_kinds kinds
      if kinds != nil
        new_kinds=kinds.inject{|kind,i|
          kind=kind+","
          kind+=i
        }
        new_kinds
      end
    end

    def get_kinds_array kinds
      new_kinds=Array.new
      return [] if kinds.nil?
      make_by_kinds(kinds)
    end

    def make_by_kinds kinds
      new_kinds=Array.new
      Programa.make_kinds.each do |kind|
        if kinds.include?(kind[1])
          new_kinds.push(kind)
        end
      end
      new_kinds
    end

  end
end
