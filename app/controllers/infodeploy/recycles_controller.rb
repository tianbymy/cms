# -*- coding: utf-8 -*-
module Infodeploy
  class RecyclesController < ApplicationController
    before_filter :dispose_check, :only => [:more_dispose]
  	def index
  	  @news = Article.get_by_state("over")
  	end

  	def destroy
  	  article = Article.find(params[:id])
  	  destroy_article_by_type(article)
  	  flash[:dispose_info]="文章删除成功!"
  	  redirect_to :action => :index
  	end

  	def recover
  	  article = Article.find(params[:article_id])
  	  article.update_attributes(:state => "draft")
  	  flash[:dispose_info]="文章已经恢复,请通过 文稿 查看!"
  	  redirect_to :action => :index
  	end

  	def more_dispose
  	  news_ids=params[:news]
      if params[:recover].nil?
      	news_ids.each do |news_id|
      	  destroy_article_by_type(Article.find(news_id))
        end
      else
      	news_ids.each do |news_id|
          Article.find(news_id).update_attributes(:state => "draft")
        end
      end
      redirect_to :action => :index
  	end

  	private
    def dispose_check
      flash[:dispose_info]=set_dispose_message
      if params[:news].nil?
        redirect_to :action => :index
      end
    end
    def set_dispose_message
      return make_dispose_info(params) if params[:news].nil?
      return "文章删除成功!" if params[:recover].nil?
      "文章已经恢复,请通过 文稿 查看!"
    end

  	def make_dispose_info params
      return "请选择要删除的文章!" if params[:recover] == nil
  	  "请选择要恢复的文章!"
  	end

  	def destroy_article_by_type article
      if article.type == "document"
      	document=Document.where(:article_id => article.id).first
      	destroy_article(document)
      end
      if article.type == "link"
      	catenate=Catenate.where(:article_id => article.id).first
      	destroy_article(catenate)
      end
      if article.type == "page"
      	alone=Alone.where(:article_id => article.id).first
      	destroy_article(alone)
      end
      if ["image","video","text"].count(article.type) == 1
      	wordage=Wordage.where(:article_id => article.id).first
      	destroy_image(article)
      	destroy_article(wordage)
      end
      return article.destroy
  	end

  	def destroy_article data
  	  if data != nil
  	  	data.destroy
  	  else
  	    false
  	  end
  	end

  	def destroy_image article
  	  if article.type == "image"
  	  	Slide.where(:article_id => article.id).each do |slide|
  	  	  slide.destroy
  	  	end
  	  end
  	end
  end
end
