module LayoutHelper

  def is_root?
    current_page?("/")
  end

  def header_class
    is_root? ? "dark-ui-header" : "light-ui-header"
  end

  def logo_class
    is_root? ? "logo-blanco" : "logo-color"
  end
end
