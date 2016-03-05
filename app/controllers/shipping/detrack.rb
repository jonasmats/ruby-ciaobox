class Shipping::Detrack
  require 'net/https'
  require 'net/http'
  require 'json'


  ############################### Collection #####################################

  # return type {'info': {}, 'result': []}
  def self.add_collection(collection_date, order_no, collection_address,
      collection_time = nil, collect_from = nil, phone = nil,
      notify_email = nil, notify_url = nil, assign_to = nil,
      instructions = nil, zone = nil, items = nil)

    uri = URI('https://app.detrack.com/api/v1/collections/create.json')
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      #req['Content-Type'] = 'application/x-www-form-urlencoded'

      req_hash = Hash.new
      params = Hash.new

      params["date"] = collection_date
      params["do"] = order_no
      params["address"] = collection_address
      params["collection_time"] = collection_time if collection_time.present?
      params["collect_from"] = collect_from if collect_from.present?
      params["phone"] = phone if phone.present?
      params["notify_email"] = notify_email if notify_email.present?
      params["notify_url"] = notify_url if notify_url.present?
      params["assign_to"] = assign_to if assign_to.present?
      params["instructions"] = instructions if instructions.present?
      params["zone"] = zone if zone.present?
      params["items"] = items if items.present?
      req_hash["key"] = Settings.detrack.api_key
      req_hash["json"] = []
      req_hash["json"] << params

      req.body = URI.encode_www_form(req_hash)
      req.body.gsub! '%3D%3E', '%3A'
      req.body.gsub! 'json=', 'json=%5B'
      req.body = req.body + '%5D'
      req.content_type = 'application/x-www-form-urlencoded'
      Rails.logger.debug("DEtraCK Params:: #{req.body}")

      http.request(req)
    end

    return res.body
  end

  def self.update_collection(collection_date, order_no, collection_address,
      collection_time = nil, collect_from = nil, phone = nil,
      notify_email = nil, notify_url = nil, assign_to = nil,
      instructions = nil, zone = nil, items = nil)

    uri = URI('https://app.detrack.com/api/v1/collections/update.json')
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)

      req_hash = Hash.new
      params = Hash.new

      params["date"] = collection_date
      params["do"] = order_no
      params["address"] = collection_address
      params["collection_time"] = collection_time if collection_time.present?
      params["collect_from"] = collect_from if collect_from.present?
      params["phone"] = phone if phone.present?
      params["notify_email"] = notify_email if notify_email.present?
      params["notify_url"] = notify_url if notify_url.present?
      params["assign_to"] = assign_to if assign_to.present?
      params["instructions"] = instructions if instructions.present?
      params["zone"] = zone if zone.present?
      params["items"] = items if items.present?

      req_hash["key"] = Settings.detrack.api_key
      req_hash["json"] = []
      req_hash["json"] << params

      req.body = URI.encode_www_form(req_hash)
      req.body.gsub! '%3D%3E', '%3A'
      req.body.gsub! 'json=', 'json=%5B'
      req.body = req.body + '%5D'
      req.content_type = 'application/x-www-form-urlencoded'

      http.request(req)
    end

    return res.body
  end

  def self.delete_collection(collection_date, order_no)
    uri = URI('https://app.detrack.com/api/v1/collections/delete.json')
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)

      req_hash = Hash.new
      params = Hash.new

      params["date"] = collection_date
      params["do"] = order_no
      req_hash["key"] = Settings.detrack.api_key
      req_hash["json"] = []
      req_hash["json"] << params

      req.body = URI.encode_www_form(req_hash)
      req.body.gsub! '%3D%3E', '%3A'
      req.body.gsub! 'json=', 'json=%5B'
      req.body = req.body + '%5D'
      req.content_type = 'application/x-www-form-urlencoded'

      http.request(req)
    end

    return res.body
  end

  def self.view_collection(collection_date, order_no)
    uri = URI('https://app.detrack.com/api/v1/collections/view.json')
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)

      req_hash = Hash.new
      params = Hash.new
      params["date"] = collection_date
      params["do"] = order_no
      req_hash["key"] = Settings.detrack.api_key
      req_hash["json"] = []
      req_hash["json"] << params

      req.body = URI.encode_www_form(req_hash)
      req.body.gsub! '%3D%3E', '%3A'
      req.body.gsub! 'json=', 'json=%5B'
      req.body = req.body + '%5D'
      req.content_type = 'application/x-www-form-urlencoded'

      http.request(req)
    end

    return res.body
  end


  ############################### Delivery #####################################

  def self.add_delivery(delivery_date, order_no, delivery_address,
      delivery_time = nil, delivery_to = nil, phone = nil,
      notify_email = nil, notify_url = nil, assign_to = nil,
      instructions = nil, zone = nil, items = nil)

    uri = URI('https://app.detrack.com/api/v1/deliveries/create.json')
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)

      params = Hash.new
      params["date"] = delivery_date
      params["do"] = order_no
      params["address"] = delivery_address
      params["delivery_time"] = delivery_time if delivery_time.present?
      params["deliver_to"] = delivery_to if delivery_to.present?
      params["phone"] = phone if phone.present?
      params["notify_email"] = notify_email if notify_email.present?
      params["notify_url"] = notify_url if notify_url.present?
      params["assign_to"] = assign_to if assign_to.present?
      params["instructions"] = instructions if instructions.present?
      params["zone"] = zone if zone.present?
      params["items"] = items if items.present?

      req_hash = Hash.new
      req_hash["key"] = Settings.detrack.api_key
      req_hash["json"] = []
      req_hash["json"] << params

      req.body = URI.encode_www_form(req_hash)
      req.body.gsub! '%3D%3E', '%3A'
      req.body.gsub! 'json=', 'json=%5B'
      req.body = req.body + '%5D'
      req.content_type = 'application/x-www-form-urlencoded'

      http.request(req)
    end

    return res.body
  end

  def self.update_delivery(delivery_date, order_no, delivery_address,
      delivery_time = nil, delivery_to = nil, phone = nil,
      notify_email = nil, notify_url = nil, assign_to = nil,
      instructions = nil, zone = nil, items = nil)

    uri = URI('https://app.detrack.com/api/v1/deliveries/update.json')
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)

      params = Hash.new
      params["date"] = delivery_date
      params["do"] = order_no
      params["address"] = delivery_address
      params["delivery_time"] = delivery_time if delivery_time.present?
      params["delivery_to"] = delivery_to if delivery_to.present?
      params["phone"] = phone if phone.present?
      params["notify_email"] = notify_email if notify_email.present?
      params["notify_url"] = notify_url if notify_url.present?
      params["assign_to"] = assign_to if assign_to.present?
      params["instructions"] = instructions if instructions.present?
      params["zone"] = zone if zone.present?
      params["items"] = items if items.present?

      req_hash = Hash.new
      req_hash["key"] = Settings.detrack.api_key
      req_hash["json"] = []
      req_hash["json"] << params

      req.body = URI.encode_www_form(req_hash)
      req.body.gsub! '%3D%3E', '%3A'
      req.body.gsub! 'json=', 'json=%5B'
      req.body = req.body + '%5D'
      req.content_type = 'application/x-www-form-urlencoded'

      http.request(req)
    end

    return res.body
  end

  def self.delete_delivery(collection_date, order_no)
    uri = URI('https://app.detrack.com/api/v1/deliveries/delete.json')
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)

      params = Hash.new
      params["date"] = collection_date
      params["do"] = order_no

      req_hash = Hash.new
      req_hash["key"] = Settings.detrack.api_key
      req_hash["json"] = []
      req_hash["json"] << params

      req.body = URI.encode_www_form(req_hash)
      req.body.gsub! '%3D%3E', '%3A'
      req.body.gsub! 'json=', 'json=%5B'
      req.body = req.body + '%5D'
      req.content_type = 'application/x-www-form-urlencoded'

      http.request(req)
    end

    return res.body
  end

  def self.view_delivery(collection_date, order_no)
    uri = URI('https://app.detrack.com/api/v1/deliveries/view.json')
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)

      params = Hash.new
      params["date"] = collection_date
      params["do"] = order_no

      req_hash = Hash.new
      req_hash["key"] = Settings.detrack.api_key
      req_hash["json"] = []
      req_hash["json"] << params

      req.body = URI.encode_www_form(req_hash)
      req.body.gsub! '%3D%3E', '%3A'
      req.body.gsub! 'json=', 'json=%5B'
      req.body = req.body + '%5D'
      req.content_type = 'application/x-www-form-urlencoded'

      http.request(req)
    end

    return res.body
  end
end