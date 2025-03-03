require 'jwt'
class JwToken
	SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

	def self.encode(payload,exp: 7.days.from_now)
		payload[:exp] = exp.to_i
		JWT.encode(payload, SECRET_KEY)
	end

	def self.decode(token)
		return nil if token.nil? || token.split('.').size != 3 
		
		decoded = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')[0]
    	HashWithIndifferentAccess.new(decoded)
    	rescue JWT::DecodeError => e
			Rails.logger.error "JWT Decode Error: #{e.message}"
    		nil
	end
end