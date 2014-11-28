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

    @dec = Decoder.new

    # Get attributes.
    n = params[:n].to_i
    public_key = params[:public_key].to_i
    data = params[:message]

    # Decode message.
    decoded_message = @dec.decode_message(n, public_key, data)

    # Feedback.
  	render json: {
      :decrypted => decoded_message,
  	}
  end

end
