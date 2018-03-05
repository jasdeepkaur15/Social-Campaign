class SocialsController < ApplicationController
	 before_action :set_id, only: [:show, :edit, :update, :destroy,:upvote,:downvote]
  
  
    def index
	  @socials = Social.all.order("created_at DESC")
	  @social = Social.new
	 end
	

	 def create
	 	@user = current_user
	 	debugger
	   @social = @user.socials.new(campaings_params)
	   if @social.save
	   	post_on_facebook(@user, @social)
	   	redirect_to socials_path
	   else
	   	render 'new'
	   end
	  end
	 
	 def new
	  
	 end

	 def show
	  
	 end

	 def update
	    if @social.update(campaings_params)
	    	debugger
	    	redirect_to socials_path
	    else
	    	render 'edit'
	    end
	 end
	 def destroy
	 	@social.destroy
	 	redirect_to root_path  #posts_path

	 end

	 def edit
	 	debugger
	 end

	def upvote
	     @social.upvote_by current_user
	     redirect_back(fallback_location: root_path)
    end
   
    def downvote
	    @social.downvote_from current_user
	     redirect_back(fallback_location: root_path)
    end


	 private
	  def campaings_params
	   params.require(:social).permit(:title,:body,:image)
	  end
	 
	 def set_id
	   @social = Social.find(params[:id])
	 end
end
