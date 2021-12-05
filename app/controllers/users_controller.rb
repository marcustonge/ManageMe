class UsersController < ApplicationController
    #checks user is signed in and an admin before allowing access to the user management page
    before_action :authenticate_user!
    before_action :must_be_admin
    
    #this controller is used by the admin to administrate user accounts
    def index
        @users = User.all
    end

    #this defines the destroy method for user accounts
    def destroy
        @user = User.find(params[:id])
    
        if @user.destroy
            redirect_to users_url, notice: t('controllers.users.deleted')
        end
    end

    #checks if the user is an admin
    private
    def must_be_admin
        unless current_user.admin?
            redirect_to events_path, alert: t('controllers.nopermission')
        end
    end
end
