module SessionsHelper
  
  #ユーザーIDを一時的セッションの中に記憶
  def log_in(user)
    session[:user_id] = user.id
  end
  
  #現在ログイン中のユーザーがいる場合、オブジェクトを返す
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: params[:user_id])
    end
  end
end
