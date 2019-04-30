class IdStockController < ApplicationController
  def SecurityMaster
    @symbol = params[:Symbol]

  end

  def Exchange
  end

  def Home
  end

  def TopGainer
  end

  def TopLoser
  end

  def UpComingDividend
  end

  def get_SecuritySymbol

    var_symbol = params[:Symbol] == nil ? '' : %q(WHERE LOWER("Symbol") = LOWER\(') + params[:Symbol] + %q('\))

    var_ExecStr = 'SELECT "SecurityName", "Region", "Startdate", "Symbol", "iexID", "StockType", exchange, currency, "isEnabled"
	  FROM public."SecurityMaster" ' + var_symbol + ' LIMIT 1'

    render json: ActiveRecord::Base.connection.execute(var_ExecStr)

  end

  def get_SecurityName
   # render json: 'Thanks for sending a GET request with cURL!'

   var_sercurity = params[:Security] == nil ? '' : %q(WHERE LOWER("SecurityName") LIKE LOWER\(') + params[:Security] + %q(%'\))

   # render json: var_sercurity
   var_ExecStr = 'SELECT "SecurityName","Symbol"
     FROM public."SecurityMaster" '+
     var_sercurity +'
     LIMIT 100'
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

end
