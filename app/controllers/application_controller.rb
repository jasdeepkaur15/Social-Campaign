class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

 def post_on_facebook(current_user,social)
   	if current_user
        # current_user.facebook.put_wall_post(social.title);
        # current_user.facebook.put_picture(social.image.path);
        current_user.facebook.put_picture(social.image.path, { "caption" => social.title })
    end
  end
  def get_url(url)
    page = Nokogiri::HTML(open(url))  
    image=  page.css("meta[property='og:image']").first.values.second
    return image
  end
  

    protected

        def configure_permitted_parameters
           devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])        
       end
	
end
  