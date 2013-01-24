#
#  File: wait_for_digit.rb
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
# wait for digit: Waits for a digit to be pressed 
# Waits up to <timeout> milliseconds for channel to receive a DTMF digit. 
# 
# Command Reference: WAIT FOR DIGIT <timeout> 
#
# failure: 200 result=-1 
# timeout: 200 result=0 
# success: 200 result=<digit> 
# <digit> is the ascii code for the digit received. 
#

class ReturnStatus
end

class WaitForDigit < ReturnStatus

	def initialize(command, response)
		super(command, response)
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

	def timeout?
		if @is_timeout.nil?
			if result == '0'
				@is_timeout = true
			else
				@is_timeout = false
			end 
		end

		return @is_timeout
	end

	def digit
		if success?
			return result.to_i.chr
		else
			return nil
		end
	end

	def success?
		return ((not timeout?) and (not failure?))
	end

	def error?
		return command_error?
	end

	def response
		return message
	end

end
