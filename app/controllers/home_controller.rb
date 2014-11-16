class HomeController < ApplicationController

	#
	# Home view
	#
  def index
  	@rsa = Cryptify::Rsa.new
		logger.fatal @rsa.instance_variable_get('@p')
  end

  #
  # Encrypt message.
  #
  def encrypt_decrypt
  	@rsa1 = Cryptify::Rsa.new

  	# Set attributes.
  	@rsa1.instance_variable_set(:@p, params[:p].to_i)
  	@rsa1.instance_variable_set(:@q, params[:q].to_i)
  	@rsa1.instance_variable_set(:@n, params[:n].to_i)
  	@rsa1.instance_variable_set(:@z, params[:z].to_i)
  	@rsa1.instance_variable_set(:@e, params[:e].to_i)
  	@rsa1.instance_variable_set(:@d, params[:d].to_i)

  	# Encrypted and decrypted.
  	encrypted = @rsa1.encrypt(params[:message].to_i)
  	decrypted = @rsa1.decrypt(encrypted)

  	render json: {
  		:encrypted => encrypted,
  		:decrypted => decrypted,
  	}
  end

end
