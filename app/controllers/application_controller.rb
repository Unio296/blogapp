class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  private

  # サインアウト後にroot_pathにリダイレクト
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
