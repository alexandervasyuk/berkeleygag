module SessionsHelper
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  def signed_in?
  	!current_user.nil?
  end

  def signed_in_user
  	unless signed_in?
      respond_to do |f|
        f.html {redirect_to signin_url, notice:"Please sign in first"}
        f.js {render :js => "window.location.href = '#{signin_url}'"}
      end
  	end
  end

  def verified_user?
    unless current_user.confirmation_code == "Verified"
      respond_to do |f|
        f.html 
        f.js {render js:"alert('Please verify your account first. You should have received an email from BerkeleyGag. Just in case, check your spam folder.');$('#post_title').val('');"}
      end
    end
  end
end