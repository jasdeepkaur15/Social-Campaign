class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
def self.from_omniauth(auth, signed_in_resource = nil)
  user = User.where(provider: auth.provider, uid: auth.uid).first
  if user.present?
    user
  else
    # Check wether theres is already a user with the same 
    # email address
    user_with_email = User.find_by_email(auth.info.email)
    if user_with_email.present?
      user = user_with_email
    else
        user = User.new
        debugger
        if auth.provider == "facebook"
        debugger
          user.provider = auth.provider
        user.uid = auth.uid
          user.oauth_token = auth.credentials.token
          
          user.first_name = auth.extra.raw_info.first_name
          user.last_name = auth.extra.raw_info.last_name
          user.email = auth.extra.raw_info.email
          # Facebook's token doesn't last forever
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
       debugger
        user.save
      elsif auth.provider == "linkedin" 
      debugger
        user.provider = auth.provider
        user.uid = auth.uid
          user.oauth_token = auth.credentials.token
          user.oauth_secret = auth.credentials.secret

          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.email = auth.info.email

        user.save
      elsif auth.provider == "twitter" 
        
          user.provider = auth.provider
        user.uid = auth.uid
          user.oauth_token = auth.credentials.token
          
          user.oauth_user_name = auth.extra.raw_info.name
           end
    end    
  end
  return user
  end
  # For Twitter (save the session eventhough we redirect user to registration page first)
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end  
  end  
  # For Twitter (disable password validation)
  def password_required?
    super && provider.blank?
  end        

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
    rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil
  
  end
  def friends_count
    facebook { |fb| fb.get_connection("me","friends").size}
  end

  def linkedin
     client = LinkedIn::Client.new('78nkm3skl20mm4', '8hH4zAVaJykjjFns')
     
    client.authorize_from_access(oauth_token,oauth_secret )
    client
  end
end
