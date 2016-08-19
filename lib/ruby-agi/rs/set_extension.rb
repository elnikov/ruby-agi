#
#  File: set_extension.rb
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
# Changes the extension for continuation upon exiting the application.
#
# Command Reference: SET EXTENSION <new extension>
#
# - extension: name or number of extension to be set
#
# 200 result=0
# Note: no checking is done to verify that the extension extists.
#       If the extension does not exist, the PBX will attempt to move to the "i" (invalid) extension.
#       If the invalid "i" extension does not exist, the call will drop
#


class ReturnStatus
end

class SetExtension < ReturnStatus

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
		return (not failure?)
	end

	def error?
		return command_error?
	end

	def response
		return message
	end

end
