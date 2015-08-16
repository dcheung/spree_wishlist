object @wished_product
node(:wishlist) {@wishlist}
child :wishlist do
	attributes :name, :access_hash, :is_private, :is_default
end
child :variant => :product do
  extends "spree/api/v1/variants/big"
end