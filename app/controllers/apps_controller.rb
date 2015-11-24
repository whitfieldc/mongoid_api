class AppsController < ApplicationController

  def index
    puts params

    case params["type"]
    when "paid"
      app_type = "paid"
    when "free"
      app_type = "free"
    end

    sort_type = (params["sort"] == "revenue") ? :revenue : :downloads
    limit = params["limit"] ? params["limit"].to_i : 400


    @apps = Ranking.find(params[:ranking_id]).apps.order_by(avg_rating: 'desc').limit(4)
    render json: @apps
  end
end

# db.apps.aggregate([{$unwind: "$testArray"}, {$sort: {"testArray.propToSortBy": -1}}, {$limit: 2}, {$group: {_id: "$_id", testArray: {$push: "$testArray"}}}])