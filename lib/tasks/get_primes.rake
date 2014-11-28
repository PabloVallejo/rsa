namespace :get_primes do

 task :process => :environment do

 		# Get files.
 		1.upto(50) do |i|
     	exec('wget http://www.yahoo.com')
 		end
 end

end
