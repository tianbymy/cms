# -*- coding: utf-8 -*-
module Infodeploy
  class Wordage
  	include Mongoid::Document
    include Mongoid::Timestamps

    field :title, :type => String
    field :content, :type => String
    field :author
    field :keyword
    field :overview
    field :permission
    field :deploy_type,:type => Integer
    field :deploy_start,:type => Time
    field :deploy_end,:type => Time
    field :image
    field :kinds
    field :article_id
    field :attachment
    field :video

    mount_uploader :attachment, AttachmentUploader
    mount_uploader :image, ImageUploader
    mount_uploader :video, VideoUploader
    validates_presence_of :title,:author,:keyword,:overview, :message => "不能为空"

    def get_kinds marked
      if self[:kinds] != nil
        if self[:kinds].include?(marked.to_s) then {:checked => true} end
      end
    end

    scope :get_by_like_attribute,(lambda do |attribute,value|
      where(attribute => /#{value}/)
    end)

    scope :search,(lambda do |value|
      any_of({:title => /#{value}/},
                {:content => /#{value}/},
                {:author => /#{value}/},
                {:overview => /#{value}/}
      )
    end)

    def make attribute
      self[:kinds]=attribute[:kinds]
      Slide.save_picture(attribute[:slide],self[:article_id])
      self
    end

    def view_title view_count
      if self[:title].length <= 17
        self[:title]
      else
        self[:title][0,view_count]+"..."
      end
    end

    def make_kinds_name
      if self[:kinds] != nil
        kinds=""
        Property.all.each do |p|
          if self[:kinds].include?(p.marked)
            kinds+=p.name+","
          end
        end
        kinds[0,(kinds.length-1)]
      end
    end

    def out_of_date
      now_time=Time.now.strftime('%Y-%m-%d %H:%M:%S').to_time.to_i
      return true if self[:deploy_type] == 1
      return true if is_out_of_date_condition(self,now_time)
      false
    end

    def is_out_of_date_condition wordage,now_time
      wordage[:deploy_end].strftime('%Y-%m-%d %H:%M:%S').to_time.to_i >= now_time
    end

    def self.out_of_date_articles articles,result
      new_articles=Array.new
      articles.each do |article|
        wordage=Wordage.where(:article_id => article.id).first
        if wordage.out_of_date == result
          new_articles.push(article.id)
        end
      end
      new_articles
    end
  end
end
