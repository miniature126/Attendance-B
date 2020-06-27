module SessionsHelper
  
  #ユーザーIDを一時的セッションの中に記憶(ログイン)
  def log_in(user)
    session[:user_id] = user.id
  end
  
  #永続的セッションを記憶する（Userモデル参照）
  def remember(user)
    user.remember
    #idをcookiesに有効期限20年で保存、保存前に暗号化
    cookies.permanent.signed[:user_id] = user.id
    #20年後に期限切れとなるremember_tokenと同じ値をcookiesに保存
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  #永続的セッションを破棄する（Userモデルを参照）
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  #一時的セッションに記憶されたユーザーIDとcurrent_userを破棄(ログアウト)
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end    
  
  #一時的セッションにいるユーザーを返す
  #それ以外の場合はcookiesに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  #渡されたユーザーがログイン済みのユーザーであればtrueを返す
  def current_user?
    @user == current_user
  end
  
  #現在ログイン中のユーザーがいる場合はtrue、居ない場合はfalseを返す
  def logged_in?
    !current_user.nil?
  end
end
