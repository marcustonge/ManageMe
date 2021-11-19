class UsersController < ApplicationController
    before_action :must_be_admin
    #this controller is used by the admin to administrate user accounts
    def index
        @users = User.all
    end

    private
    def must_be_admin
        unless current_user.admin?
            redirect_to events_path, alert: "You don't have permission to access to this page"
        end
    end
end
