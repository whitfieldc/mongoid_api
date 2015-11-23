class App
  include Mongoid::Document

  field :name
  field :id
  field :publisher
  field :icon_url
  field :link
  field :avg_rating, type: Decimal
  field :price, type: Decimal
  field :global_ratings, type: Integer
  field :in_country_ratings, type: Integer
  field :downloads, type: Integer
  field :revenue, type: BigDecimal


  embedded_in :product
end
