module Api
    class WishController < Spree::Api::BaseController
        def create
            @user = load_user
            logger.info "parameters : #{params.inspect}"
            logger.info "user : #{@user.inspect}"

            @wished_product = Spree::WishedProduct.new(wish_attributes)
            @wishlist = @user.wishlist

            params[:wish][:wishlist_id] = params[:wishlist_id]

            if @wishlist.include? params[:wish][:variant_id]
                @wished_product = @wishlist.wished_products.detect { |wp| wp.variant_id == params[:wish][:variant_id].to_i }
            else
                @wished_product.wishlist = @user.wishlist
                @wished_product.save
            end

            @variant = @wished_product.variant
            @product = @variant.product
            logger.info "wished product : #{@wished_product.inspect}"

            @wished_product
        end

        def destroy
            logger.info "destroy  wish"
            @user = load_user
            @wishlist = @user.wishlist

            logger.info "parameters : #{params.inspect}"
            logger.info "user : #{@user.inspect}"

            @wished_product = Spree::WishedProduct.find_by(variant_id: params[:id], wishlist_id: @wishlist.id)
            @wished_product.destroy unless @wished_product.nil?

            if @wished_product.nil?
                logger.error "unable to find wishlist item"
                @error = "WishlistNotFound"
                @error_message = "wishlist item not found error"
                @error_code = 404
                render "api/errors/wishlist_error", status: 404 and return
            end            
        end

        private

        def wish_attributes
            params.require(:wish).permit(:variant_id, :wishlist_id, :remark)
        end
    end
end
