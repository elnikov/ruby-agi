#
#  File: receive_char.rb
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
require 'ruby-agi/error.rb'

#
# class to handle return status of Command#receive_char
# Receives a character of text on a channel, and discards any further characters after the first one waiting.
# Most channels do not support the reception of text. See Asterisk Text for details.
#
# Command Reference: RECEIVE CHAR <timeout>
#
# failure or hangup: 200 result=-1 (hangup)
# timeout: 200 result=<char> (timeout)
# success: 200 result=<char>
# <char> is the character received, or 0 if the channel does not support text reception.
#

class ReturnStatus
end

class ReceiveChar < ReturnStatus

	def initialize(command, response)
		super(command, response)
	end

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

	def hangup?
		if @is_hangup.nil?
			rgx = Regexp.new(/\(hangup\)$/)
			if rgx.match(response)
				@is_hangup = true

				if not failure?
					raise(UnknownError, "Please report to info@beeplove.com with as much information as you can provide")
				end
			else
				@is_hangup = false
			end
		end

		return @is_hangup
	end

	def success?
		return ((not timeout?) and (not failure?))
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

	def char
		if result == '0'
			return nil
		elsif not failure?
			return result.to_i.chr
		else
			return nil
		end
	end

	def error?
		return command_error?
	end

	def response
		return message
	end

end
