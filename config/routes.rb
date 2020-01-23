Rails.application.routes.draw do
  root to: 'tasks#index'
  post     'load_data'   => 'tasks#show'
  post     'add_data'    => 'tasks#store'
  put      'update_data/:id' => 'tasks#update'
  post     'delete_data/:id' => 'tasks#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
