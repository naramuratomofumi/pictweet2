Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index' #http://localhost:3000へアクセスすると、Railsの「初期画面」が表示されてしまいます。このパスにアクセスしても、トップページを表示させるようにルーティングを編集
  resources :tweets do
    resources :comments, only: :create #ルーティングのネスト どのツイートに対するコメントなのかをパスから判断できるようにする
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
end
