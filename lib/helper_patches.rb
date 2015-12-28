# Load our helpers
require 'helpers/layout_helper'

Rails.configuration.to_prepare do
  ActionView::Base.send(:include, LayoutHelper)
end

# this code was taken from the rails source: https://github.com/rails/rails/blob/3-2-stable/actionpack/lib/action_view/helpers/form_tag_helper.rb#L417
# we're monkey patching the submit_tag method to include the btn and btn-default classes from Bootstrap only when no other classes are specified
module ActionView
  module Helpers
    module FormTagHelper
      def submit_tag(value = "Save changes", options = {})
        options = options.stringify_keys

        if disable_with = options.delete("disable_with")
          options["data-disable-with"] = disable_with
        end

        if confirm = options.delete("confirm")
          options["data-confirm"] = confirm
        end

        # patch
        options['class'] = 'btn btn-default' if options['class'].blank?

        tag :input, { "type" => "submit", "name" => "commit", "value" => value }.update(options)
      end
    end
  end
end
