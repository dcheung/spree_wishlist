module Api
    class WishlistsController < Spree::Api::BaseController
        def index
            @user = load_user
            logger.info "parameters : #{params.inspect}"
            logger.info "user : #{@user.inspect}"

            @wishlist = @user.wishlist
            @wished_products = @wishlist.wished_products
        end
    end
end
