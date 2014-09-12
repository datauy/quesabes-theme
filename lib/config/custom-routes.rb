if Rails.env != "test"
    Alaveteli::Application.routes.draw do
        # Additional help pages
        match '/help/help_out' => 'help#help_out', :as => 'help_help_out'

        match '/help/press' => 'help#press', :as => 'help_press'
        match '/help/privacy_policy' => 'help#privacy_policy', :as => 'help_privacy_policy'
        match '/help/terms_of_use' => 'help#terms_of_use', :as => 'help_terms_of_use'

        match '/help/borrador_transparencia' => 'help#borrador_transparencia', :as => 'help_borrador_transparencia'
        match '/help/proyecto_transparencia' => 'help#proyecto_transparencia', :as => 'help_proyecto_transparencia'
        
        # We want to start by showing the public bodies categories and search only
        match '/body/' => 'public_body#index', :as => "body_index"
    end
end