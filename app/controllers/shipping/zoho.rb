class Shipping::Zoho

  require 'net/https'
  require 'net/http'
  require 'json'

  # constant values
  public
  def self.products
    {standard: "248986000000073005", fly: "248986000000073005"}
  end

  def self.plans
    {standard: "100", fly: "101"}
  end

  def self.addons
    {"1" => "1000", "2" => "1001", "3" => "1100", "4" => "1101", "5" => "1102", "6" => "1103", "7" => "1104", "8" => "1105", "9" => "1106", "10" => "1200"}
  end

  # Create/Retrieve a Product
  public
  def self.create_product(name, description = nil, email_ids = nil, redirect_url = nil)
    uri = URI("https://subscriptions.zoho.com/api/v1/products")
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token

      req_hash = Hash.new
      req_hash["name"] = name
      if description.present?
        req_hash["description"] = description
      end
      if email_ids.present?
        req_hash["email_ids"] = email_ids
      end
      if redirect_url.present?
        req_hash["redirect_url"] = redirect_url
      end

      req.body = req_hash.to_json
      http.request(req)
    end

    return res.body
  end

  def self.retrieve_product(product_id)
    url_str = "https://subscriptions.zoho.com/api/v1/products/" + product_id
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new(uri)
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token
      http.request(req)
    end

    return res.body
  end

  # Create/Retrieve a Plan
  def self.create_plan(plan_code, name, recurring_price, interval, product_id)
    uri = URI("https://subscriptions.zoho.com/api/v1/plans")
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token

      req_hash = Hash.new
      req_hash["plan_code"] = plan_code
      req_hash["name"] = name
      req_hash["recurring_price"] = recurring_price
      req_hash["interval"] = interval
      req_hash["product_id"] = product_id

      req.body = req_hash.to_json
      http.request(req)
    end

    return res.body
  end

  def self.retrieve_plan(plan_code)
    url_str = "https://subscriptions.zoho.com/api/v1/plans/" + plan_code
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new(uri)
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token
      http.request(req)
    end

    return res.body
  end

  # Create/Retrieve an Addon
  def self.create_addon(addon_code, name, unit_name, price, product_id, description)
    url_str = "https://subscriptions.zoho.com/api/v1/addons"
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token

      req_hash = Hash.new
      req_hash["addon_code"] = addon_code
      req_hash["name"] = name
      req_hash["unit_name"] = unit_name
      req_hash["price_brackets"] = [{"price" => price}]
      req_hash["type"] = "one_time"
      req_hash["product_id"] = product_id
      req_hash["description"] = description

      req.body = req_hash.to_json
      http.request(req)
    end

    return res.body
  end

  def self.retrieve_addon(addon_code)
    url_str = "https://subscriptions.zoho.com/api/v1/addons/" + addon_code
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new(uri)
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token
      http.request(req)
    end

    return res.body
  end

  # Create/Retrieve/Delete a Coupon
  def self.create_coupon(coupon_code, name, discount_by, discount_value, expiry_at, product_id, description)
    url_str = "https://subscriptions.zoho.com/api/v1/coupons"
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token

      req_hash = Hash.new
      req_hash["coupon_code"] = coupon_code
      req_hash["name"] = name
      req_hash["type"] = "one_time"
      req_hash["discount_by"] = discount_by
      req_hash["discount_value"] = discount_value
      req_hash["product_id"] = product_id
      req_hash["expiry_at"] = expiry_at
      req_hash["description"] = description
      req.body = req_hash.to_json

      http.request(req)
    end

    return res.body
  end

  def self.retrieve_coupon(coupon_code)
    url_str = "https://subscriptions.zoho.com/api/v1/coupons/" + coupon_code
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new(uri)
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token
      http.request(req)
    end

    return res.body
  end

  def self.delete_coupon(coupon_code)
    url_str = "https://subscriptions.zoho.com/api/v1/coupons/" + coupon_code
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Delete.new(uri)
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token
      http.request(req)
    end

    return res.body
  end


  # Create/Retrieve a Customer
  def self.create_customer(display_name, email, first_name = nil, last_name = nil, phone = nil, billing_address = nil, shipping_address = nil, currency_code = 'CHF')
    uri = URI("https://subscriptions.zoho.com/api/v1/customers")
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token

      req_hash = Hash.new
      req_hash["display_name"] = display_name
      req_hash["email"] = email
      req_hash["currency_code"] = currency_code

      if first_name.present?
        req_hash["first_name"] = first_name
      end
      if last_name.present?
        req_hash["last_name"] = last_name
      end
      if phone.present?
        req_hash["phone"] = phone
      end
      if billing_address.present?
        req_hash["billing_address"] = billing_address
      end
      if shipping_address.present?
        req_hash["shipping_address"] = shipping_address
      end

      req.body = req_hash.to_json
      http.request(req)
    end

    Rails.logger.debug("ZOHO RESPONSE:: #{res.body}")
    return res.body
  end


  def self.retrieve_customer(customer_id)
    if customer_id.blank?
      return nil
    end

    url_str = "https://subscriptions.zoho.com/api/v1/customers/" + customer_id
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new(uri)
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token
      http.request(req)
    end

    return res.body
  end

  def self.update_customer(customer_id, display_name, email, first_name = nil, last_name = nil, phone = nil, billing_address = nil, shipping_address = nil, currency_code = 'CHF')
    url_str = "https://subscriptions.zoho.com/api/v1/customers/" + customer_id
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Put.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token

      req_hash = Hash.new
      req_hash["display_name"] = display_name
      req_hash["email"] = email
      req_hash["currency_code"] = currency_code

      if first_name.present?
        req_hash["first_name"] = first_name
      end
      if last_name.present?
        req_hash["last_name"] = last_name
      end
      if phone.present?
        req_hash["phone"] = phone
      end
      if billing_address.present?
        req_hash["billing_address"] = billing_address
      end
      if shipping_address.present?
        req_hash["shipping_address"] = shipping_address
      end

      req.body = req_hash.to_json
      http.request(req)
    end

    return res.body
  end

  # Create a Hosted Page for New Subscription
  def self.create_hostedpage(customer_id, contactperson_id, plan_code, redirect_url)
    url_str = "https://subscriptions.zoho.com/api/v1/hostedpages/newsubscription"
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token

      req_hash = Hash.new
      req_hash["customer_id"] = customer_id
      #req_hash["contactpersons"] = [{"contactperson_id": contactperson_id}]
      req_hash["plan"] = {"plan_code": plan_code}
=begin
      req_hash["plan"] = {
          "plan_code": "basic-monthly",
          "price": price,
          "plan_description": "This is the monthly basic plan",
          "quantity": 1,
          "billing_cycles": -1
      }
=end
      req_hash["redirect_url"] = redirect_url

      req.body = req_hash.to_json
      http.request(req)
    end

    return res.body
  end

  def self.update_hostedpage(subscription_id, customer_id, contactperson_id, price, redirect_url)
    url_str = "https://subscriptions.zoho.com/api/v1/hostedpages/updatesubscription"
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token

      req_hash = Hash.new
      req_hash["subscription_id"] = subscription_id
      req_hash["customer_id"] = customer_id
      req_hash["contactpersons"] = [{"contactperson_id": contactperson_id}]
      req_hash["plan"] = {
          "plan_code": "basic-monthly",
          "price": price,
          "plan_description": "This is the monthly basic plan",
          "quantity": 1,
          "billing_cycles": -1
      }
      req_hash["redirect_url"] = redirect_url

      req.body = req_hash.to_json
      http.request(req)
    end

    return res.body
  end

  def self.update_card_hostedpage(subscription_id, redirect_url)
    url_str = "https://subscriptions.zoho.com/api/v1/hostedpages/updatecard"
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token
      req_hash = Hash.new
      req_hash["subscription_id"] = subscription_id
      req_hash["redirect_url"] = redirect_url
      req.body = req_hash.to_json
      http.request(req)
    end
    return res.body
  end

  #Create a Subscription
  def self.create_subscription(customer_id, plan_code, addons = nil, coupon_code = nil, starts_at = nil)
    url_str = "https://subscriptions.zoho.com/api/v1/subscriptions"
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token

      req_hash = Hash.new
      req_hash["customer_id"] = customer_id
      req_hash["plan"] = {
          "plan_code": plan_code
          #"price": price,
          #"plan_description": "This is the monthly basic plan",
          #"quantity": 1,
          #"billing_cycles": -1
      }
      req_hash["auto_collect"] = false
      if addons.present?
        req_hash["addons"] = addons
      end
      if coupon_code.present?
        req_hash["coupon_code"] = coupon_code
      end
      if starts_at.present?
        req_hash["starts_at"] = starts_at
      end

      req.body = req_hash.to_json
      http.request(req)
    end

    return res.body
  end

  #Retrieve a subscription
  def self.retrieve_subscription(subscription_id)
    url_str = "https://subscriptions.zoho.com/api/v1/subscriptions/" + subscription_id
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new(uri)
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token
      http.request(req)
    end
    return res.body
  end

  #Associate/Remove coupon with Subscription
  def self.associate_coupon(subscription_id, coupon_code)
    url_str = "https://subscriptions.zoho.com/api/v1/subscriptions/" + subscription_id + "/coupons/" + coupon_code
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Put.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token
      http.request(req)
    end

    return res.body
  end

  def self.remove_coupon(subscription_id)
    url_str = "https://subscriptions.zoho.com/api/v1/subscriptions/" + subscription_id + "/coupons"
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Delete.new(uri)
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token
      http.request(req)
    end

    return res.body
  end

  #Invoice
  def self.retrieve_invoice(invoice_id)
    url_str = "https://subscriptions.zoho.com/api/v1/invoices/" + invoice_id
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new(uri)
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token
      http.request(req)
    end

    return res.body
  end

  def self.collect_charge(invoice_id)
    url_str = "https://subscriptions.zoho.com/api/v1/invoices/" + invoice_id + "/collect"
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token
      http.request(req)
    end

    return res.body
  end

  def self.email_invoice(invoice_id, from_email, to_email, cc_email, subject, body)
    url_str = "https://subscriptions.zoho.com/api/v1/invoices/" + invoice_id + "/email"
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json;charset=UTF-8'
      req['X-com-zoho-subscriptions-organizationid'] = Settings.zoho.organ_id
      req['Authorization'] = 'Zoho-authtoken ' + Settings.zoho.auth_token

      req_hash = Hash.new
      req_hash["from_mail_id"] = from_email
      req_hash["to_mail_ids"] = [to_email]
      req_hash["cc_mail_ids"] = [cc_email]
      req_hash["subject"] = subject
      req_hash["body"] = body

      req.body = req_hash.to_json
      http.request(req)
    end

    return res.body
  end
end