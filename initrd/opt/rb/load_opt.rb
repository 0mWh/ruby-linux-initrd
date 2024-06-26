#!/usr/bin/ruby

def load_opt name
	Dir.glob("/opt/rb-opt/#{name}*.rb").map do |file|
		[file, load(file)]
	end.to_h
end
