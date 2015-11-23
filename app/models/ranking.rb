class Ranking
  include Mongoid::Document

  field :date

  embeds_many :apps
end
