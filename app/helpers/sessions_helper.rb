module SessionsHelper
  
  #ユーザーIDを一時的セッションの中に記憶(ログイン)
  def log_in(user)
    session[:user_id] = user.id
  end
  
  #一時的セッションに記憶されたユーザーIDを破棄(ログアウト)
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end    
  
  #現在ログイン中のユーザーがいる場合、オブジェクトを返す
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  #現在ログイン中のユーザーがいる場合はtrue、居ない場合はfalseを返す
  def logged_in?
    !current_user.nil?
  end
end
