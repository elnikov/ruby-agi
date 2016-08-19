#
#  File: channel_status.rb
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
# class to handle return status of Command#channel_status
# Returns the status of the specified channel. 
# If no channel name is given the returns the status of the current channel. 
#
# Command Reference: CHANNEL STATUS [<channelname>] 
#
# failure: 200 result=-1 
# success: 200 result=<status> 
# <status> values: 
# 0 Channel is down and available 
# 1 Channel is down, but reserved 
# 2 Channel is off hook 
# 3 Digits (or equivalent) have been dialed 
# 4 Line is ringing 
# 5 Remote end is ringing 
# 6 Line is up 
# 7 Line is busy 
#

class ReturnStatus
end

class ChannelStatus < ReturnStatus
	VALID_STATUS = ['0', '1', '2', '3', '4', '5', '6', '7']

	def initialize(command, response)
		super(command, response)
	end

	def success?
		if not failure?
			if VALID_STATUS.include?(result)
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

	# 0 Channel is down and available 
	def available?
		return result == '0'
	end

	# 1 Channel is down, but reserved 
	def reserved?
		return result == '1'
	end

	# 2 Channel is off hook 
	def off_hook?
		return result == '2'
	end

	# 3 Digits (or equivalent) have been dialed 
	def dialed?
		return result == '3'
	end

	# 4 Line is ringing 
	def ringing?
		return result == '4'
	end

	# 5 Remote end is ringing 
	def remote_ringing?
		return result == '5'
	end

	# 6 Line is up 
	def up?
		return result == '6'
	end

	# 7 Line is busy 
	def busy?
		return result == '7'
	end

	def error?
		return command_error?
	end

	def response
		return message
	end

end
