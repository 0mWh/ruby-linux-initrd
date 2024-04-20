#!/usr/bin/ruby

def video

	# modprobe everything fbdev-related
	load_mod 'drivers/video/fbdev'

	# clear old fbdev
	if File.exist? '/dev/fb0'
		File.delete '/dev/fb0'
	end

	# create & open fbdev file
	system '/bin/mknod', '/dev/fb0', 'c', '29', '0'
	$display = File.open '/dev/fb0', 'wb'

end

def colorize h, int=false

	case h
	when Integer

		if int
			# num -> num
			h
		else
			# num -> bytes
			[h].pack('i').unpack('C3')
		end
		
	when Array
		if int
			# bytes -> num
			([0]+h).pack('C4').unpack('N')
		else
			h
		end

	else
		throw 'wrong type'
	end

end

def point framebuffer, x, y, width, height, bytes, color

	# seek to pixel
	framebuffer.seek(y * width * bytes + x * bytes)

	# write color
	colorize(color).each do |byte|
		framebuffer.putc byte
	end

	# draw screen
	framebuffer.flush

end

def screen framebuffer, width, height, bytes

	framebuffer.rewind

	screen =
	height.times.map do |y|
		width.times.map do |x|
			yield(x, y)
		end
	end

	framebuffer.write screen.flatten.pack('C*')
	framebuffer.flush

end
