require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'rankings.csv'), encoding: "ISO8859-1")

csv = CSV.parse(csv_text, :headers => true)

today = Ranking.create({date: "20150508"})

already_created = {}

def translate_app_hash(raw_app_hash)
  combined_downloads = (raw_app_hash["iPhone downloads"].to_i) + (raw_app_hash["iPad downloads"].to_i)
  iphone_revenue = raw_app_hash["iPhone revenue"] ? raw_app_hash["iPhone revenue"].gsub("$", "").to_f : 0.0
  ipad_revenue = raw_app_hash["iPad revenue"] ? raw_app_hash["iPad revenue"].gsub("$", "").to_f : 0.0
  combined_revenue = (iphone_revenue + ipad_revenue)
  cleaned_hash = {
    name: raw_app_hash["App name"],
    id: raw_app_hash["App ID"],
    publisher: raw_app_hash["Company"],
    icon_url: raw_app_hash["App icon"],
    link: raw_app_hash["App URL"],
    avg_rating: raw_app_hash["Rating"].to_f,
    price: raw_app_hash["Price"].to_f,
    global_ratings: raw_app_hash["Global ratings"].to_i,
    in_country_ratings: raw_app_hash["Country ratings"].to_i,
    downloads: combined_downloads,
    revenue: combined_revenue
  }
end


csv.each do |row|
  app_entry = row.to_hash

  app_id = app_entry["App ID"]
  puts app_id
  unless already_created[app_id]
    cleaned_app_options = translate_app_hash(app_entry)
    today.apps.build(cleaned_app_options)
    if today.save
      already_created[app_id] = "yes"
    end
  end

end
