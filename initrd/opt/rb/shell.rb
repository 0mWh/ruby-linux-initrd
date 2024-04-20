#!/usr/bin/ruby

begin
	DIR_STACK
rescue
	DIR_STACK = []
end

def cd dir=nil
	if dir.nil? || dir.empty?
		Dir.chdir ENV["HOME"]
	elsif not File.exist? dir
		throw "cd: #{dir}: No such file or directory"
	elsif not File.directory? dir
		throw "cd: #{dir}: Not a directory"
	else
		Dir.chdir dir
		Dir.pwd
	end
end

def pushd dir
	if not File.exist? dir
		throw "pushd: #{dir}: No such file or directory"
	elsif not File.directory? dir
		throw "pushd: #{dir}: Not a directory"
	else
		DIR_STACK.push Dir.pwd
		cd dir
		DIR_STACK
	end
end

def popd n=1
	n.times do
		throw 'popd: directory stack empty' if DIR_STACK.empty?
		cd DIR_STACK.pop
	end
	DIR_STACK
end
