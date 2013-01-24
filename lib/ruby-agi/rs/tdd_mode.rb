#
#  File: tdd_mode.rb
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
# tdd mode: Activates TDD mode on channels supporting it, to enable communication with TDDs.
# Enable/Disable TDD transmission/reception on a channel. 
# This function is currently (01July2005) only supported on Zap channels. 
# As of 02July2005, this function never returns 0 (Not Capable).
# If it fails for any reason, -1 (Failure) will be returned, otherwise 1 (Success) will be returned.
# The capability for returning 0 if the channel is not capable of TDD MODE is a future plan. 
# 
# Command Reference: TDD MODE <on|off|mate> 
#
# failure: 200 result=-1 
# not capable: 200 result=0 
# success: 200 result=1
#

class ReturnStatus
end

class TDDMode < ReturnStatus

	def initialize(command, response)
		super(command, response)
	end

	def success?
		if @is_success.nil?
			if result == '1'
				@is_success = true
				@is_capable = true
				@is_failure = false
			end 
		end

		return @is_success
	end

	def failure?
		if @is_failure.nil?
			if result == '-1'
				@is_failure = true
				@is_capable = true
				@is_success = false
			end 
		end

		return @is_failure
	end

	def capable?
		if @is_capable.nil?
			if result == '0'
				@is_capable = false
				@is_success = false
				@is_failure = true
			else
				@is_capable = true
			end
		end
		
		return @is_capable
	end

	def error?
		return command_error?
	end

	def response
		return message
	end

end
