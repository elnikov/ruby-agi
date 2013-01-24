#
#  File: verbose.rb
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
# Sends <message> to the console via verbose message system. 
# The Asterisk verbosity system works as follows.
# The Asterisk user gets to set the desired verbosity at startup time
# or later using the console 'set verbose' command.
# Messages are displayed on the console if their verbose level
# is less than or equal to desired verbosity set by the user.
# More important messages should have a low verbose level;
# less important messages should have a high verbose level. 
#
# Command Reference: VERBOSE <message> [level] 
#
# 200 result=1 
# 

class ReturnStatus
end

class Verbose < ReturnStatus

	def initialize(command, response)
		super(command, response)
	end

	def success?
		if @is_success.nil?
			if result == '1'
				@is_success = true
			else
				@is_success = false
			end 
		end

		return @is_success
	end

	def failure?
		return (not success?)
	end

	def error?
		return command_error?
	end

	def response
		return message
	end

end
