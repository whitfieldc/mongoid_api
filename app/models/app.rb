class App
  include Mongoid::Document

  embedded_in :product
end
