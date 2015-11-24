class Ranking
  include Mongoid::Document

  field :date
  field :_id, type: String, default: -> { date.parameterize }

  embeds_many :apps
end
