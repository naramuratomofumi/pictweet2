class UsersController < ApplicationController
  def show
    user = User.find(params[:id]) #ツイートの右下に表示されるユーザー名をクリックすることで、送られたidをparamsで取得し、そのユーザーのレコードを変数userに代入しています。この変数を利用して、各インスタンス変数ではcurrent_userを変数userに変えました
    @nickname = user.nickname     #@nicknameでは、ユーザーのnicknameを取り出しています。
    @tweets = user.tweets         #アソシエーションを利用しuser.tweetsとすることで、そのユーザーが投稿したツイートを取得して、@tweetsに代入しています
  end
end