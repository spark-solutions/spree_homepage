Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin do
    resources :home_page_sections do
      collection do
        post :update_positions
      end
    end
    resources :home_page_fields
    resource :instagram_settings, only: %i[edit update destroy]
    resources :instagram_posts, only: [:index] do
      collection do
        get :download
        post :update_visibility
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
        get '/instagram_feed', to: 'instagram#feed'
        resources :instagram_posts, only: %i[index]
        resources :home_page_sections, only: %i[index]
      end
    end
  end
end
