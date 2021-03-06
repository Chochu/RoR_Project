class IdStockController < ApplicationController
  def SecurityMaster
    @symbol = params[:Symbol]
  end

  def Exchange
    var_ExecStr = 'SELECT * FROM public."ExchangeMaster"'
    @result = ActiveRecord::Base.connection.execute(var_ExecStr)
  end

  def Home
  end

  def TopGainer
    @result = JSON.parse(get_SecurityList("gainers"))

  end

  def TopLoser

    @result = JSON.parse(get_SecurityList("losers"))
    @result.each { |item|
      item["openTime"] =          UnixTimeConvert(item["openTime"])
      item["closeTime"] =         UnixTimeConvert(item["closeTime"])
      item["latestUpdate"] =      UnixTimeConvert(item["latestUpdate"])
      item["delayedPriceTime"] =  UnixTimeConvert(item["delayedPriceTime"])
      item["extendedPriceTime"] = UnixTimeConvert(item["extendedPriceTime"])
      item["iexLastUpdated"]    = UnixTimeConvert(item["iexLastUpdated"])

      #{} "change": -46.49, price
      #{} "changePercent": -0.5575, %

    }

  end

  def UpComingDividend
  end

  def UnixTimeConvert(varUnix)
      return Time.at(varUnix).strftime "%m-%d-%Y %H:%M:%S"
  end

  def get_SecuritySymbol

    var_symbol = params[:Symbol] == nil ? '' : %q(WHERE LOWER("Symbol") = LOWER\(') + params[:Symbol] + %q('\))
    var_ExecStr = 'SELECT * FROM public."SecurityMaster" ' + var_symbol + ' LIMIT 1'

    render json: ActiveRecord::Base.connection.execute(var_ExecStr)

  end

  def get_SecurityName

   if params[:Security] == nil
     render json: 'No Security Provided'
   end

   var_ExecStr = %q(SELECT * from public.uf_getsecuritymasterlike\(') + params[:Security] + %q('\))

   #render json: var_ExecStr
   render json: ActiveRecord::Base.connection.execute(var_ExecStr)
  end

  def get_SecurityStat
    if params[:Symbol] == nil
      render json: 'No Symbol Provided'
    end
    var_exi_url = 'https://sandbox.iexapis.com/stable/stock/'+ params[:Symbol] + '/stats?token=' + Rails.application.credentials.IEX[:SAND_TOKEN]

    response = RestClient::Request.execute(
      method: :get,
      url: var_exi_url
    )

    render json: response
  end

  def get_SecurityDetail
   # var_exi_url = 'https://cloud.iexapis.com/stable/stock/' + params[:symbol] + '/company?token='+ Rails.application.credentials.IEX[:TOKEN]
   var_exi_url = 'https://sandbox.iexapis.com/stable/stock/' + params[:Symbol] + '/company?token='+ Rails.application.credentials.IEX[:SAND_TOKEN]

   response = RestClient::Request.execute(
     method: :get,
     url: var_exi_url
   )

   render json: response
  end

  def get_SecurityList(listType)

    # /stock/market/list/mostactive
    # /stock/market/list/gainers
    # /stock/market/list/losers
    # /stock/market/list/iexvolume
    # /stock/market/list/iexpercent

    base_url = 'https://sandbox.iexapis.com/stable/stock/market/list/' + listType + '?token='+ Rails.application.credentials.IEX[:SAND_TOKEN]

    response = RestClient::Request.execute(
      method: :get,
      url: base_url
    )

    return response
  end

end
