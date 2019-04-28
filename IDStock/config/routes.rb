Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :login
  root "login#index"

  get 'id_stock/SecurityMaster'
  get 'id_stock/Exchange'
  get 'id_stock/TopGainer'
  get 'id_stock/TopLoser'
  get 'id_stock/Home'

  match 'id_stock/Security' => 'id_stock#get_SecurityName', via: :get
  match 'id_stock/SecurityDetails' => 'id_stock#get_SecurityDetail', via: :get
  # match 'id_stock/Summary'  => 'id_stock#Summary', via: :post

end
