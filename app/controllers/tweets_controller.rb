class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :search] #indexアクションにアクセスした場合、indexアクションへのリダイレクトを繰り返してしまい、無限ループが起こります。この対策として、except: :indexを付け加えています。

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new # tweets/show.html.erbでform_withを使用して、comments#createを実行するリクエストを飛ばしたいので、@comment = Comment.newというインスタンス変数を生成
    @comments = @tweet.comments.includes(:user)  # tweetsテーブルとcommentsテーブルはアソシエーションが組まれているので、@tweet.commentsとすることで、@tweetへ投稿されたすべてのコメントを取得できる。またincludesメソッドを使って、N+1問題を解決している点にも注意
  end

  def search
    @tweets = Tweet.search(params[:keyword])  # searchメソッドの引数にparams[:keyword]と記述して、検索結果を渡しています。
  end

  private

  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end
  
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?         ##unlessでuser_signed_in?を判定して、その返り値がfalseだった場合にredirect_toが実行されます。すなわち、ユーザーがログインしていない場合にはindexアクションが実行されます。
      redirect_to action: :index
    end
  end
end
