Rails.application.routes.draw do
  
  devise_for :users, controllers:{
  	omniauth_callbacks: "users/omniauth_callbacks"
  }

  root 'main#home'

  #Autenticacion con facebook
  # 1 Mandar una peticion a facebook
  # 2 Facebook retorna a nuestra app callback_url
  # 3 Procesar la info de Facebook
  # 4 Autenticar al usuario o crear uno nuevo


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
