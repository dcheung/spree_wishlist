object @wished_product
node(:wishlist) {@wishlist}
child :wishlist do
	attributes :name, :access_hash, :is_private, :is_default
end
child(@product) do
  extends "spree/api/v1/products/show"
end