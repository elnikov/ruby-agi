#
#  File: send_text.rb
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
# Sends the given text on a channel.
# Most channels do not support the transmission of text.
# Text consisting of greater than one word should be placed in quotes since the command only accepts a single argument.
#
# <b>Parameters</b>
# - text : text to be send 
#
# <b>Returns</b>
# - ReturnStatus (object)
#
# failure: 200 result=-1
# success: 200 result=0 
#
# Command Reference: SEND TEXT "<text to send>"
#

class ReturnStatus
end

class SendText < ReturnStatus

	def initialize(command, response)
		super(command, response)
	end

	def success?
		if @is_success.nil?
			if result == '0'
				@is_success = true
			else
				@is_success = false
			end 
		end

		return @is_success
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

	def error?
		return command_error?
	end

	def response
		return message
	end

end
