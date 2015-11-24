class AppsController < ApplicationController

  def index

    sort_type = (params["sort"] == "revenue") ? :revenue : :downloads
    limit = params["limit"] ? params["limit"].to_i : 400

    case params["type"]
    when "paid"
      rejection_lambda = lambda {|app| app.price == 0}
    when "free"
      rejection_lambda = lambda {|app| app.price != 0}
    else
      rejection_lambda = lambda {|app| false }
    end

    @apps = Ranking.find(params[:ranking_id])
      .apps
      .reject(&rejection_lambda)
      .sort{|app_one, app_two| app_two[sort_type] <=> app_one[sort_type]}
      .take(limit)
    render json: @apps
  end
end

# db.apps.aggregate([{$unwind: "$testArray"}, {$sort: {"testArray.propToSortBy": -1}}, {$limit: 2}, {$group: {_id: "$_id", testArray: {$push: "$testArray"}}}])