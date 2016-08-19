#
#  File: wait_for_digits.rb
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

require_relative 'return_status.rb'

#
# class to handle return status from Command#wait_for_digits
# pressing '#' will always terminate the input process
#
# Command Reference: GET DATA <file to be streamed> [timeout] [max digits]
#
# failure: 200 result=-1
# timeout: 200 result=<digits> (timeout)
# success: 200 result=<digits>
# <digits> is the digits pressed. 
#

class ReturnStatus
end

class WaitForDigits < ReturnStatus

	def initialize(command, response)
		super(command, response)
	end

	def success?
		return ((not failure?) and (not timeout?)) 
	end

	def failure?
		if @is_failure.nil?
			if result == '-1'
				@is_failure = true
			else
				@is_failure = false
			end 
		end

		return @is_failure
	end

	public
	def timeout?
		if @is_timeout.nil?
			rgx = Regexp.new(/\(timeout\)$/)
			if rgx.match(response)
				@is_timeout = true
			else
				@is_timeout = false
			end
		end

		return @is_timeout
	end

	def digits
		return result
	end

	def error?
		return ((not timeout?) and command_error?)
	end

	def response
		return message
	end

end
