module Api
    class WishlistsController < Spree::Api::BaseController
        skip_before_action :authenticate_user, only: :guest

        def create
            @wished_product = Spree::WishedProduct.new(wished_product_attributes)
            @wishlist = spree_current_user.wishlist

            if @wishlist.include? params[:product][:variant_id]
              @wished_product = @wishlist.wished_products.detect { |wp| wp.variant_id == params[:product][:variant_id].to_i }
            else
              @wished_product.wishlist = spree_current_user.wishlist
              @wished_product.save
            end

            @wished_product
        end

        private
    end
end