#!/usr/bin/ruby3.2

def pwd
	Dir.pwd
end

def cat *files
	files.map do |file|
		File.read(file)
	end
end

require_relative 'shell.rb'
def dir *args
	if args.empty?
		[['.', Dir.glob('*')]]
	else
		args.map do |arg|
			dir  = File.dirname arg
			base = File.basename arg
			pushd dir
			if not File.exist? base
				ans = nil
			elsif not File.directory? base
				ans = true
			else
				pushd base
				ans =
				Dir.glob('*').map do |entry|
					if File.directory? entry
						entry + "/"
					else
						entry
					end
				end
				popd
			end
			popd
			[arg, ans]
		end
	end.to_h
end
