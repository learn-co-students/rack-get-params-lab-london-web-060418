class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      if @@cart.length < 1
        resp.write "Your cart is empty"
      else @@cart.each do |cart_item|
        resp.write "#{cart_item}\n"
      end
    end
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      @@cart << search_term
      "added #{search_term}"
    else
       "We don't have that item"
    end
  end

end
