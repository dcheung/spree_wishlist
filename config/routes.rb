Spree::Core::Engine.add_routes do
    resources :wishlists
    resources :wished_products, only: [:create, :update, :destroy]
    get '/wishlist' => 'wishlists#default', as: 'default_wishlist'

    namespace :api, defaults: { format: 'json' } do
        resources :wishlists do
            collection do
                post :product
            end
        end
    end
end
