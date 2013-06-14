# -*- coding: utf-8 -*-
module Infodeploy
  class Video
    include Mongoid::Document
    include Mongoid::Timestamps
    field :title
    field :video
    field :image
    field :description
    field :number

    mount_uploader :video, VideoUploader
    mount_uploader :image, ImageUploader
  end
end
