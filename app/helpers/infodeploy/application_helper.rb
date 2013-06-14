# -*- coding: utf-8 -*-
module Infodeploy
  module ApplicationHelper

    def error_div(model, field, field_name)
      return unless model
      field = field.is_a?(Symbol) ? field.to_s : field
      errors = model.errors[field]
      return unless errors
      %Q(
      <div class="error-message">
      #{errors.is_a?(Array) ? errors.map{|e|
      field_name + e}.join(",") : field_name << errors}
      </div>
      ).html_safe
    end

    def error_span(model, field, field_name)
      return unless model
      field = field.is_a?(Symbol) ? field.to_s : field
      errors = model.errors[field]
      return unless errors
      %Q(
      <span class="error-message">
      #{errors.is_a?(Array) ? errors.map{|e|
      field_name + e}.join(",") : field_name << errors}
      </span>
      ).html_safe
    end

    def admin_navicates
      navicates=Infodeploy::ResolveFile.get_admin_navicates
      results=""
      results += %Q(
      <div class='adminmenu'>
        <ul class="menushow">
      )
      navicates.each do |navicate|
        results += %Q(                    
            <li class="menuli"><a class="menutitle" href="javascript:void(0)">#{navicate[:title]}</a>
            <ul class="submenu">)
        navicate[:navicates].each do |n|
          results += %Q(<li class="submenuli"><a href ="#{n[:url]}">#{n[:title]}</a></li>)
        end
        results += %Q(</ul></li>)
      end
        results += %Q(</ul></div>)
        results.html_safe
    end

    def get_name (array)
      array.map(&:name).join(" ")
    end

    def register_errors marked,name,errors
      if errors != nil
        if errors[marked] != nil
            %Q(
            <span class="errorspan">
            #{make_errors(errors[marked],name)}
            </span>
            ).html_safe
        else
          %Q(
            <span class="rightspan">
            </span>
            ).html_safe
        end
      end
    end

    private
    def make_errors errors,name
      new_errors=""
      errors.each do |error|
        new_errors+=name+error+","
      end
      errors_length=new_errors.length
      new_errors[0,(errors_length-1)]
    end

  end
end
