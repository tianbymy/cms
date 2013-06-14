# -*- coding: utf-8 -*-
module Infodeploy
  class ArticleQueriesController < ApplicationController
    before_filter :attributes_check,:only => [:attribute_query]
  	def attribute_query
  	  @keyword=params[:keyword]
      @news=Article.where(send("query_condition_by_#{@attributes_name}")).desc("racking").paginate(:page => params[:page], :per_page => 20)
  	  render "infodeploy/articles/deploy"
  	end

  	private
    def attributes_check
			@attributes_name=params[:attributes]["name"]
      if @attributes_name.empty?
    	  flash[:query_info]="搜索条件不能为空!"
    	  redirect_to :controller => :articles,:action => :deploy,:page => params[:page]	
      end
    end

    def query_condition_by_channel
      make_articles_by_channel
    end

    def query_condition_by_auditor
      {(params[:attributes]["name"]).to_sym => /#{params[:keyword]}/}
    end

    def query_condition_by_title
      {"_id".to_sym.in => make_article_ids(params[:attributes]["name"],params[:keyword])}
    end

    def query_condition_by_author
      {"_id".to_sym.in => make_article_ids(params[:attributes]["name"],params[:keyword])}
    end

		def query_condition_by_state
      @status=params[:states]["id"]
			send(@status)	
    end

    def displaing
      wordage_articles=Article.get_articles(["text","image","video"])
      {"_id".to_sym.in => Wordage.out_of_date_articles(wordage_articles,true)+make_news_ids(Article.get_articles(["link","document","page"]))}
    end

    def out_of_date
      wordage_articles=Article.get_articles(["text","image","video"])
      {"_id".to_sym.in => Wordage.out_of_date_articles(wordage_articles,false)}
    end

    def out_of_stock
      {:racking => 0}
    end

  	def make_article_ids attribute,keyword
      ids=Wordage.where(attribute.to_sym => /#{keyword}/).map{|wordage| wordage.article_id}
  	end

    def make_news_ids articles
      ids=articles.map{|article| article.id}
    end

  	def make_articles_by_channel
      conditions={}
  	  @channel=params[:channels]["id"]
      conditions[:channel_id]= @channel
      conditions=make_articles_by_programa(conditions)
			conditions[:state]="success"
			conditions
  	end

    def make_articles_by_programa conditions
      if ["","null"].count(params[:programas]["id"]) == 0
        @programa=params[:programas]["id"]
        conditions[:programa_id]=@programa
      end
      conditions
    end
  end
end
