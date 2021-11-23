class UsersController < ApplicationController
    #checks user is signed in and an admin before allowing access to the user management page
    before_action :authenticate_user!
    before_action :must_be_admin
    
    #this controller is used by the admin to administrate user accounts
    def index
        @users = User.all
    end

    #checks if the user is an admin
    private
    def must_be_admin
        unless current_user.admin?
            redirect_to events_path, alert: "You don't have permission to access to this page"
        end
    end
end
