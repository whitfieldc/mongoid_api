class Ranking
  include Mongoid::Document

  field :date, type: String

  embeds_many :apps
end
