
# Main file
jQuery ->

	# What does rails will receive?
	$('.js-message').keyup ->
			if not $(this).val().length then return

			message = $(this).val()
			rsaAttributes.message = message

			# Send post request.
			$.post '/home/encrypt-decrypt',
				rsaAttributes
				(resp) ->
					console.log resp
					$('.js-decrypted').text(resp.decrypted)
					$('.js-encrypted').text(resp.encrypted)
