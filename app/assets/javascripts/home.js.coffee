
# Main file
jQuery ->

	# What does rails will receive?
	$('.js-message').keyup ->
			if not $(this).val().length then return

			data =
				message: $('.js-message').val().split(',')
				n: $('.js-n').val()
				public_key: $('.js-public-key').val()

			# Send post request.
			$.post '/home/encrypt-decrypt',
				data
				(resp) ->
					console.log resp
					$('.js-decrypted').text(resp.decrypted)
