#
#  File: receive_text.rb
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

# class to handle return status of Command#receive_text 
# Receives a string text on a channel.
# Most channels do not support the reception of text.
#
# Command Reference: RECEIVE TEXT <timeout>
#
# failure, hangup, or timeout: 200 result=-1
# success: 200 result=<text>
# <text> is the text received on the channel.
#

class ReturnStatus
end

class ReceiveText < ReturnStatus

	def initialize(command, response)
		super(command, response)
	end

	def success?
		return (not failure?)
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

	def text
		return result
	end

	def error?
		return command_error?
	end

	def response
		return message
	end

end
