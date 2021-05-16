module JYRon
  module Adapters
    private
    def symbolize_keys
      @object.deep_transform_keys! { |key| (key.class == String)? key.to_sym : key } if @object.class == Hash
      if @object.class == Array then
        @object.each do |item| item.deep_transform_keys! {|key| (key.class == String)? key.to_sym : key } if item.class == Hash end
      end
    end

    def stringify_keys
      object.deep_transform_keys!{|key| (key.class == Symbol)? key.to_s : key } if @object.class == Hash
      if @object.class == Array then
        @object.each do |item| item.deep_transform_keys!{|key| (key.class == Symbol)? key.to_s: key} if item.class == Hash end
      end
    end

    def upcase_keys
      object.deep_transform_keys!{|key| (key.class == String)? key.upcase : key } if @object.class == Hash
      if @object.class == Array then
        @object.each do |item| item.deep_transform_keys!{|key| (key.class == String)? key.upcase: key} if item.class == Hash end
      end
    end

    def snakecase_keys
      object.deep_transform_keys!{|key| (key.class == String)? key.underscore : key } if @object.class == Hash
      if @object.class == Array then
        @object.each do |item| item.deep_transform_keys!{|key| (key.class == String)? key.underscore: key} if item.class == Hash end
      end
    end

    def camelcase_keys
      object.deep_transform_keys!{|key| (key.class == String)? key.camelize : key } if @object.class == Hash
      if @object.class == Array then
        @object.each do |item| item.deep_transform_keys!{|key| (key.class == String)? key.camelize: key} if item.class == Hash end
      end
    end

  end
end
