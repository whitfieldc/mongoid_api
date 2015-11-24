class AppsController < ApplicationController
  before_action :allow_cross_domain

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

  private

  def allow_cross_domain
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, X-Prototype-Version, Content-Type, Accept, Authorization, Token'
  end
end

# db.apps.aggregate([{$unwind: "$testArray"}, {$sort: {"testArray.propToSortBy": -1}}, {$limit: 2}, {$group: {_id: "$_id", testArray: {$push: "$testArray"}}}])