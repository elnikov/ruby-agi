#
#  File: record_file.rb
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
# class to handle return status of Command#record_file
# Record to a file until <escape digits> are received as dtmf.
#
# failure to write: 200 result=-1 (writefile)
# failure on waitfor: 200 result=-1 (waitfor) endpos=<offset>
# hangup: 200 result=0 (hangup) endpos=<offset>
# interrrupted: 200 result=<digit> (dtmf) endpos=<offset>
# timeout: 200 result=0 (timeout) endpos=<offset>
# random error: 200 result=<error> (randomerror) endpos=<offset>
# <offset> is the end offset in the file being recorded.
# <digit> is the ascii code for the digit pressed.
# <error> ?????
#
# Command Reference: RECORD FILE <filename> <format> <escape digits> <timeout> [offset samples] [BEEP] [s=<silence>]
#

class ReturnStatus
end

class RecordFile < ReturnStatus

	def initialize(command, response)
		super(command, response)
	end

	def failure?
		if @is_failure.nil?
			if result == '-1'
				@is_failure = true
				rgx_write	= Regexp.new(/\(writefile\)/)
				rgx_waitfor	= Regexp.new(/\(waitfor\)/)
				@is_failure_to_write	= rgx_write.match(response).nil?	? false : true
				@is_failure_on_waitfor	= rgx_waitfor.match(response).nil?	? false : true
			else
				@is_failure = false
			end 
		end

		return @is_failure
	end

	def failure_to_write?
		if failure?
			return @is_failure_to_write
		else
			return false
		end
	end

	def failure_on_waitfor?
		if failure?
			return @is_failure_on_waitfor
		else
			return false
		end
	end

	def hangup?
		if @is_hangup.nil?
			@is_hangup = false
			if result == '0'
				rgx= Regexp.new(/\(hangup\)/)
				if rgx.match(response)
					@is_hangup = true
				end
			end
		end

		return @is_hangup
	end

	def interrupted?
		if @is_interrupted.nil?
			@is_interrupted = false
			if ((not failure?) and (result != '0'))
				rgx= Regexp.new(/\(dtmf\)/)
				if rgx.match(response)
					@is_interrupted = true
				end
			end
		end

		return @is_interrupted
	end

	def timeout?
		if @is_timeout.nil?
			@is_timeout = false
			if result == '0'
				rgx= Regexp.new(/\(timeout\)/)
				if rgx.match(response)
					@is_timeout = true
				end
			end
		end

		return @is_timeout
	end

	def random_error?
		if @is_random_error.nil?
			@is_random_error = false
			if ((not failure?) and (result != '0'))
				rgx= Regexp.new(/\(randomerror\)/)
				if rgx.match(response)
					@is_randomerror = true
				end
			end
		end

		return @is_randomerror
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

	def success?
		return (not failure?)
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
