Rails.application.routes.draw do
  root to: 'tweets#index' #http://localhost:3000へアクセスすると、Railsの「初期画面」が表示されてしまいます。このパスにアクセスしても、トップページを表示させるようにルーティングを編集
  resources :tweets, only: [:index, :new, :create, :destroy, :edit, :update, :show]
end
