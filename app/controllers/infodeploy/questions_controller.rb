# -*- coding: utf-8 -*-
module Infodeploy
  class QuestionsController < ApplicationController
    before_filter :get_question, :only => [:new,:create,:replies]
  	def index
  	  @questions=Question.all.desc("created_at").paginate(:page => params[:page], :per_page => 15)
  	end

  	def new
  	  @ask=Ask.new
  	end

  	def create
  	  @ask=Ask.new(params[:ask])
  	  @ask.question_id=@question.id
  	  if @ask.save
  	  	redirect_to :action => :index
  	  else
  	  	render "new"
  	  end
  	end

  	def replies
  	  @asks=Ask.where(:question_id => @question.id)
  	end

  	def delete_repliy
  	  Ask.find(params[:repliy_id]).destroy
  	  redirect_to :action => :replies,:question_id => params[:question_id]
  	end

  	def destroy
  	  question_id=params[:id]
  	  Question.find(question_id).destroy
  	  Ask.where(:question_id => question_id).each do |ask|
  	  	ask.destroy
  	  end
  	  redirect_to :action => :index
  	end

    private
    def get_question
      @question=Question.find(params[:question_id])
    end
  end
end
