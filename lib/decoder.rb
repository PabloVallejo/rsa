# Decoder modude


#
# RSA implementation class.
#
# Ported to ruby from:
#
# 	https://github.com/jag2kn/DecifradorMesajes
#
class Decoder

	#
	# Finds what the private key is.
	def find_private_key(p, q, e)

		# n = p * q
		phi = (p - 1) * (q - 1)


		# Phy
		phiT = phi
		eT = e

		#
		quotient = 1
		quotients = []
		i = 0
		modulus = 1

		# Cycle.
		while modulus != 0 do
			quotient = phiT / eT
			quotients << quotient
			modulus  = phiT % eT
			phiT = eT
			eT = modulus
			i = i + 1
		end

		xT = 1
		yT = 0

		i = quotients.length - 1
		while i != -1 do
			xTT = xT
			xT = yT
			yT = xTT - (yT * quotients[i])
			i = i - 1
		end


		if yT < 0
			yT = yT + phi
		end

		d = yT
	 	d

	end

	#
	# Modular
	#
	def modular_inverse(k, n, s)

		i = 1
		t = sprintf("%b", k)

		r = s
		p = s
		# a = s
		i = 1
		while i != t.length do

			if t[i] == "1"
				r = (r*r*p) % n
			else
				r = (r*r)%n
			end
			i = i + 1
		end

		r

	end


	#
	# Return an array of primes based on textfiles
	#
	def get_factors_from_file(i, n)

		line_num = 0

		# Read file.
		File.open("#{Rails.root}/lib/primes/primes#{i}.txt", 'r') do |f|
		  f.each_line do |line|

		  	if line_num > 2
		  		primes = line.split(' ')

		  		primes.each do |x|
		  			x.strip!

		  			if x.length > 0
		  				p = x.to_i
		  				reminder = n % p

		  				if reminder == 0
		  					return p
		  				end

		  			end


		  		end
		  	end

		    line_num += 1
		  end
		end

		# Return n.
		n

	end


	#
	# Find factos
	#
	def find_factors(n)
		p = n
		counter = 1
		while p == n and counter <= 50 do
			p = get_factors_from_file(counter, n);
			counter = counter + 1
		end

		p
	end


	#
	# Decode message.
	#
	def decode_message(n, public_key, data)

		p = find_factors(n)
		q = n / p
		message = ''

		private_key = find_private_key(p, q, public_key)
		data.each do |d|
			r = modular_inverse(private_key, n, d.to_i)
			message = message + r.chr
		end

		# Return formed message.
		message

	end

end