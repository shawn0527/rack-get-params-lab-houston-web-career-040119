class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    @resp = Rack::Response.new
    @req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def add(item)
    if @@items.include?(item)
      @@cart << item
      resp.write "added #{item}"
    else
      resp.write "We don't have that itme"
    end
  end


  def cart
    if @@cart = []
      resp.write "Your cart is empty"
    else
    @@cart.each do |item|
      resp.write "#{item}\n"
    end
  end
end
