# -*- coding: utf-8 -*-
module Infodeploy
  class ArticlesController < ApplicationController
  	before_filter :get_article,:only => [:show,:edit,:destroy,:update]
    before_filter :get_by_article_id,:only => [:waiting_audit_show,:draft_show,:edit_channel,:send_audit]
    before_filter :audit_articles_check,:only => [:more_deploy]
    before_filter :recycle_check,:only => [:empty_recycle]
    before_filter :send_audit_check,:only => [:send_more_audit]
    def index
      @news = Article.where(:state => "draft").desc("created_at").desc("channel_id")
    end

    def new
      @channel=params[:channel_id]
      @programa=params[:programa_id]
      @article = Article.new
    end

    def edit
      @page=params[:page]
    end

    def edit_channel
      params_article=params[:article]
      @page=params[:page]
      if article_type_check(params_article,@article)
        update_article_render_page(@article,params_article)
      else
        render "edit"
      end
    end

    def site_channel
      params_article=params[:article]
      @article = Article.new(params_article)
      @article=receive_channel(@article,params)
      if @article.draft == false
        if article_type_check(params_article,@article)
          make_site_data(params,@article)
          render "report"
        else
          render "new"
        end
      end
    end

    def create
      @channel=params[:channel]
      @programa=params[:programa]
      @article = Article.new(params[:article])
      @article=make_news_channel(@article,@channel,@programa)
      @article[:creator]=session[:cas_user]
      if make_content(@article).save
        @article[:racking] = 1
        @article.draft
        redirect_to check_operate(@channel,@programa,@article)
      else
        render "report"
      end
    end

    def update
      @page=params[:page]
      get_channel_programa(@article.channel_id,@article.programa_id)
      @article.update_attributes(:updated_at => Time.now)
      if update_content(@article).errors.size == 0
        redirect_to :action => params[:page]
      else
        render "edit_report"
      end
    end

    def destroy
      if ["text","image","video"].include?(@article.type)
	Wordage.where(:article_id => @article.id).first.destroy
      end
      if ["link"].include?(@article.type)
	Catenate.where(:article_id => @article.id).first.destroy
      end
      if ["document"].include?(@article.type)
	Document.where(:article_id => @article.id).first.destroy
      end
      if ["page"].include?(@article.type)
	Alone.where(:article_id => @article.id).first.destroy
      end
      @article.destroy
      redirect_to :action => params[:page]
    end

    def send_more_audit
      @news_ids.each do |news_id|
        Article.find(news_id).waiting_audit
      end
      redirect_to :action => :index
    end

    def send_audit
      @article.waiting_audit
      flash[:send_audit_info]="发送成功!"
      redirect_to :action => :index
    end

    def empty_recycle
      @news_ids.each do |news_id|
        Article.find(news_id).destroy
      end
      redirect_to :action => :recycle
    end

    def waiting_audit
      @news = Article.get_by_state("waiting").desc("updated_at")
    end

    def deploy
      @news = Article.get_by_state("success").desc("racking").desc("created_at").desc("channel_id").paginate(:page => params[:page], :per_page => 20)
    end

    def lower_rack
      article = Article.find(params[:article_id])
      article.update_attributes(:racking => 0)
      redirect_to :action => :deploy
    end

    def more_deploy
      audit_article(params,@news_ids)
      redirect_to :action => :waiting_audit
    end

    def audit
      audit_article(params,[params[:article_id]])
      redirect_to :action => :waiting_audit
    end

    private
    def check_operate channel,programa,article
      return {:action => :new,:channel_id => channel,:programa_id => programa} if params["save_agin"] != nil
      return {:action => :index} if params['save'] != nil
      article.waiting_audit
      {:action => :waiting_audit}
    end

    def send_audit_check
      @news_ids=params[:news]
      flash[:send_audit_info]=set_send_audit_message
      if @news_ids.nil?
        redirect_to :action => :index
      end
    end

    def set_send_audit_message
      return "请选择要发送至审核的文章!" if @news_ids.nil?
      "文章发送至审核成功!"
    end

    def recycle_check
      @news_ids=params[:news]
      flash[:recycle_info]=set_recycle_message
      if @news_ids.nil?
        redirect_to :action => :recycle
      end
    end

    def set_recycle_message
      return "请选择要删除的文章" if @news_ids.nil?
      "文章删除成功!"
    end

    def audit_articles_check
      @news_ids=params[:news]
      flash[:result] = set_error_message
      if @news_ids.nil?
        redirect_to :action => :waiting_audit
      end
    end


    def audit_article params,article_ids
      more_audit_dispose(article_ids, (deployed? ? "pass" : "fails"))
    end

    def set_error_message
     return (deployed? ?  "请选择要发布的文章!" : "请选择要移至回收站的文章!") if params[:news].nil?
     deployed? ?  "文章发布成功,请通过已发布查看文章!" : "文章审核失败,请通过回收站查看文章!"
    end

    def deployed?
      not params[:deploy].nil?
    end

    def article_type_check params_article,article
      return false if params_article[:channel_id] == ""
      return true if params_article[:type] != "page"
      exist?(article,params_article)

    end

    def exist? article,params_article
      type_article=Article.where(:type => params_article[:type],:channel_id => params_article[:channel_id],:programa_id => params_article[:programa_id]).first
      return true if type_article == nil
      return get_channel_programa(article.channel_id,article.programa_id),true if same?(type_article,article)
      flash[:error_info]="该栏目的单页面已经存在!"
      false
    end

    def same? type_article,article
      type_article.id.to_s == article.id.to_s
    end

    def receive_channel article,params
      if params[:channel_id] != nil
        article.channel_id=params[:channel_id]
        article.programa_id=params[:programa_id]
        article
      else
        article
      end
    end

    def more_audit_dispose news_ids,result
			news_ids.each do |news_id|
      	audit_dispose(news_id,result)
 			end
    end

    def audit_dispose article_id,result
			article=Article.find(article_id)
			article[:auditor]=session[:cas_user]
			article[:audit_date]=Time.now.strftime('%Y-%m-%d %H:%M:%S')
      article.send(result)
    end

    def make_content article
      @article_attributes = article.make_attribute(Programa.get_class_by_type(article.type),params)
    end


    def update_content article
      @article_attributes = article.update_by(Programa.get_class_by_type(article.type),params)
    end

    def update_article_render_page article,params_article
      if article.update_attributes(params_article)
        get_channel_programa(article.channel_id,article.programa_id)
        render "edit_report"
      else
        render "edit"
      end
    end

    def get_article
      @article = Article.find(params[:id])
    end

    def get_by_article_id
      @article = Article.find(params[:article_id])
    end

    def get_kinds kind
      if kind != nil
        kinds=kind.inject{|kind,i|
          kind=kind+","
          kind+=i
        }
        kinds
      end
    end

    def get_channel_programa channel,programa
      if channel != nil
        @channel=channel
        if programa != nil
          @programa=programa
        end
      end
    end

    def make_news_channel news,channel,programa
      if channel != nil
        news.channel_id = channel
        news.programa_id=programa
        news
      else
        news
      end
    end

    def make_site_data params,article
      if params[:channel_id]== nil
        get_channel_programa(article.channel_id,article.programa_id)
      else
        @channel=params[:channel_id]
        @programa=params[:programa_id]
      end
    end
  end
end
