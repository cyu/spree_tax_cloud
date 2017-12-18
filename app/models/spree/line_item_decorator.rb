Spree::LineItem.class_eval do
  def tax_cloud_cache_key
    key = "Spree::LineItem #{id}: #{quantity}x<#{variant.cache_key}>@#{price}#{currency}promo_total<#{promo_total}>"
    if order.ship_address
      key << "shipped_to<#{order.ship_address.try(:cache_key)}>"
    elsif order.bill_address
      key << "billed_to<#{order.bill_address.try(:cache_key)}>"
    end
    if (order_promo = order.adjustments.eligible.promotion.sum(:amount).abs) > 0
      key << "order_promo<#{order_promo}>"
    end
    key
  end
end
