# Load our helpers
require 'helpers/layout_helper'

Rails.configuration.to_prepare do
    ActionView::Base.send(:include, LayoutHelper)
end
