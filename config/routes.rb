Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin do
    resources :home_page_sections do
      collection do
        post :update_positions
      end
    end
    resources :home_page_fields
    resources :home_page_section_types
    resources :home_page_field_types
    resource :instagram_settings, only: %i[destroy]
    resources :instagram_posts, only: [:index] do
      collection do
        get :download
        post :update_all
      end
    end
    namespace :instagram_callbacks do
      get :connect
      get :callback
    end
  end
  namespace :api, defaults: { format: 'json' } do
    namespace :v2 do
      namespace :storefront do
        resources :instagram_posts, only: %i[index]
        resources :home_page_sections, only: %i[index]
      end
    end
  end
end
