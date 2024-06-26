#!/usr/bin/ruby

def find x='.'
	Dir.glob(x + '*').reduce([]) do |acc, c|
		if not File.directory? c
			acc + [c]
		else
			acc + find(c + '/')
		end
	end
end
