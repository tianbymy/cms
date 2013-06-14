# -*- coding: utf-8 -*-
module Infodeploy
  class Widgets
    include Mongoid::Document
    include Mongoid::Timestamps
    def self.get_widgets
      portlets_path="#{Rails.root.to_s}/app/views/portlets"
      list=[]
      Dir.glob(portlets_path+"/_*.h{a,t}ml").each  do |file|
        file=File.basename(file)
        list << file
      end
      list.sort
    end

  end
end
