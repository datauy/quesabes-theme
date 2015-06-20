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

  def show_status(status)
    css = if ["internal_review", "requires_admin", "not_held"].include? status
            "delate"
          elsif["waiting_response", "waiting_clarification"].include? status
            "waiting"
          elsif ["error_message", "rejected", "unsatisfactory_response",
                 "gone_postal", "user_withdrawn"].include? status
            "wrong"
          elsif ["successful", "partially_successful"].include? status
            "success"
          end
    css
    "<h4 class=\"status #{css}\"> #{ _(status)}</h4>".html_safe
  end

  def public_body_follower_count(public_body)
    TrackThing.count(
      :all,
      conditions: ["public_body_id = ?", public_body.id]
    )
  end
end
