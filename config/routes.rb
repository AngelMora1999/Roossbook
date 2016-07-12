Rails.application.routes.draw do
  
  devise_for :users, controllers:{
  	omniauth_callbacks: "users/omniauth_callbacks"
  }

  post "/custom_sign_up", to: "users/omniauth_callbacks#custom_sign_up"


  authenticated :user do
    root 'main#home'
  end

  unauthenticated :user do
    devise_scope :user do
      root "main#unregistered", as: :unregistered_root
    end
  end

  #Autenticacion con facebook
  # 1 Mandar una peticion a facebook
  # 2 Facebook retorna a nuestra app callback_url
  # 3 Procesar la info de Facebook
  # 4 Autenticar al usuario o crear uno nuevo


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
