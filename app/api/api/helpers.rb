module API
  module Helpers
    def current_user
      # Customer::User.where(email: params[:email])
    end

    # yap, very strong auth logic here
    def authenticated
      headers['X-Auth-Token'] == "superpupertoken"
    end
  end
end
