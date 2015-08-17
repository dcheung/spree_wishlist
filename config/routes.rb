Spree::Core::Engine.add_routes do
    resources :wishlists
    resources :wished_products, only: [:create, :update, :destroy]

    get '/wishlist' => 'wishlists#default', as: 'default_wishlist'
end

Rails.application.routes.draw do
    namespace :api, defaults: { format: 'json' } do
    	resources :wishlists do
    	end
    	
        resources :wish do
        end
    end
end
