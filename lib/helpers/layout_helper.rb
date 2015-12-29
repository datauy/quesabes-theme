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

  def public_body_follower_count(public_body)
    TrackThing.count(
      :all,
      conditions: ["public_body_id = ?", public_body.id]
    )
  end
end
