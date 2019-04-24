Rails.application.routes.draw do
  get 'id_stock/SecurityMaster'
  get 'id_stock/Exchange'
  get 'id_stock/Summary'
  get 'id_stock/TopGainer'
  get 'id_stock/TopLoser'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :login
  root "login#index"

end
 
