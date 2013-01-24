#
#  File: stream_file.rb
#
#  ruby-agi: Ruby Language API for Asterisk
#
#  Copyright (C) <2006>  Mohammad Khan <info@beeplove.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ruby-agi/rs/return_status'

#
# stream file: Sends audio file on channel
# Send the given file, allowing playback to be interrupted by the given digits, if any. 
# Use double quotes for the digits if you wish none to be permitted. 
# If sample offset is provided then the audio will seek to sample offset before play starts. 
# Remember, the file extension must not be included in the filename. 
# 
# Command Reference: STREAM FILE <filename> <escape digits> [sample offset] 
#
# - filename	: location of the file to be played
# - escape_digit: digit to be pressed to escape from playback
#
# failure: 200 result=-1 endpos=<sample offset> 
# failure on open: 200 result=0 endpos=0 
# success: 200 result=0 endpos=<offset> 
# digit pressed: 200 result=<digit> endpos=<offset> 
# <offset> is the stream position streaming stopped. If it equals <sample offset> there was probably an error. 
# <digit> is the ascii code for the digit pressed. 
#

class ReturnStatus
end

class StreamFile < ReturnStatus

	def initialize(command, response)
		super(command, response)
	end

	def failure?
		if @is_failure.nil?
			if result == '-1'
				@is_failure = true
			elsif result == '0'
				if offset == '0'
					@is_failure			= true
					@is_failure_on_open	= true
					@is_success			= false
				else
					@is_success			= true
				end
			else
				@is_failure = false
			end 
		end

		return @is_failure
	end

	def success?
		if @is_success.nil?
			if ((not failure?) and (offset.to_i > 0)) 
				@is_success = true
			else
				@is_success = false
			end
		end
		
		return @is_success
	end

	def interrupted?
		if @is_interrupted.nil?
			@is_interrupted = false
			if ((success?) and (result.to_i > 0))
				@is_interrupted = true
			end
		end

		return @is_interrupted
	end

	def offset
		if @offset.nil?
			rgx = Regexp.new(/^endpos/)
			response.split(' ').each do | pair |
				if rgx.match(pair)
					@offset = pair.split('=').last
				end
			end
			@offset = '' if @offset.nil?
		end

		return @offset
	end

	def digit
		if @digit.nil?
			if interrupted?
				@digit = result.to_i.chr
			end
			@digit = '' if @digit.nil?
		end
		
		return @digit
	end

	def error
		if random_error?
			return result
		else
			return ''
		end
	end

	def error?
		return command_error?
	end

	def response
		return message
	end

end
