class UsersController < ApplicationController

	def register
		user = User.new(user_params)
		if user.save
			render json: { message: 'Successfully created the User' }, status: :created
		else
			render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def login
		user = User.find_by(email: params[:email])
		if user&& user.authenticate(params[:password])
			payload = { user_id: user.id }
			token = JwToken.encode(payload)
			render json: { token: token, message: 'Login successful' }, status: :ok
		else
	      render json: { error: 'Incorrect email or password' }, status: :unauthorized
	    end
	end


	private

	def user_params
		params.permit(:name, :email, :password, :phone, :status)
	end
end
