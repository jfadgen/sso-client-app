Rails.application.routes.draw do
  root "welcome#index"


  resources :welcome, only: [:index, :sign_out] do
    collection do
      get 'sign_out'
    end
  end
end
