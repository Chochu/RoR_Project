class IdStockController < ApplicationController
  def SecurityMaster
    @sitename_count = ActiveRecord::Base.connection.execute("SELECT sitename, COUNT(sitename) FROM master GROUP BY sitename")
  end

  def Exchange
  end

  def Summary
  end

  def TopGainer
  end

  def TopLoser
  end

  def UpComingDividend
  end
end
