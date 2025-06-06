# encoding: utf-8

require "carrierwave"
require "uuidtools"
require "fog/aws"

module CarrierWaveDirect

  module Uploader
    require "carrierwave_direct/uploader/configuration"
    require "carrierwave_direct/uploader/default_url"

    CarrierWave::Uploader::Base.send(:include, Configuration)
    CarrierWave::Uploader::Base.send(:include, DefaultUrl)
  end

  module Test
    autoload :Helpers, 'carrierwave_direct/test/helpers'
    autoload :CapybaraHelpers, 'carrierwave_direct/test/capybara_helpers'
  end
end

if defined?(Rails)
  module CarrierWaveDirect
    class Railtie < Rails::Railtie

      initializer "carrierwave_direct.active_record" do
        ActiveSupport.on_load :active_record do
          require 'carrierwave_direct/orm/activerecord'
        end
      end

      initializer "carrierwave_direct.action_view" do
        ActiveSupport.on_load :action_view do
          require 'carrierwave_direct/form_builder'
          require 'carrierwave_direct/action_view_extensions/form_helper'
        end
      end
    end
  end
end

require "carrierwave_direct/mount"
require "carrierwave_direct/uploader"
require "carrierwave_direct/version"

