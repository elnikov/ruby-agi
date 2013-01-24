#
#  File: return_status.rb
#
#  ruby-agi: Ruby Language API for Asterisk
#
#  Copyright (C) <2005>  Mohammad Khan <info@beeplove.com>
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


#  every method of this class would return string or boolean
#  methods of command class usually return ReturnStatus object


class ReturnStatus

	def initialize(command, message)
		@command	= command.to_s.strip
		@message	= message.to_s.strip
	end

	public
	def command
		return @command
	end

	public
	def message
		return @message
	end

	public
	def return_code
		if @return_code.nil?
			str = message.split(' ')
			@return_code = str[0].to_s.strip
		end
		
		return @return_code
	end

	public
	def result
		if @result.nil?
			str = message.split(' ')
			@result = str[1].split('=')[1].to_s.strip
		end

		return @result
	end

=begin
	public
	def result
		if @result.nil?
			str = message.split(' ')
			@result = Result.new(str[1].split('=')[1].to_s.strip)
		end

		return @result.to_s
	end
=end

	public
	def to_s
		return command + ' >> ' + message
	end

	public	
	def command_error?
		if @is_command_error.nil?
			if (result.empty? or (not (return_code == '200')))
				@is_command_error = true
			else
				@is_command_error = false
			end
		end

		return @is_command_error
	end

end

class Answer < ReturnStatus
end
