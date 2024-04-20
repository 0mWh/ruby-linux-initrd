#!/usr/bin/ruby

def load_mod path
	find('/lib/modules/' + %x[ uname -r ].strip + '/kernel/' + path).select do |f|
		f.end_with? '.ko'
	end.map do |f|
		system '/sbin/modprobe', '-s', f
	end
end


