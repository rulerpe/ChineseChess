class Cell
	attr_accessor :value
	def initialize (value)
		@value = value
	end
end

class Board
	attr_accessor :gird
	def initialize
		@gird = default_gird
		setup
	end

	def default_gird
		Array.new(9){ Array.new(10) { Cell.new("-")}}
	end

	def setup
		bottom = ["C","M","X","S","J","S","X","M","C"]	
		@gird.each_index do |x|
			@gird[x][0].value = bottom[x]
			@gird[x][9].value = bottom[x].downcase
			if [0,2,4,6,8].include?(x)
				@gird[x][3].value = "B"
				@gird[x][6].value = "b"
			end
		end
		@gird[1][2].value ="P"
		@gird[7][2].value ="P"

		@gird[1][7].value ="p"
		@gird[7][7].value ="p"
	end

	def display
		puts "1 2 3 4 5 6 7 8 9"
		@gird[0].each_index do |y|
			@gird.each_index do |x|
				print @gird[x][y].value + " "
			end
			puts ""
		end
	end
end

class Player
	attr_accessor :color, :name
	def initialize (color,name)
		@color = color
		@name = name
	end
end

class Game
	attr_accessor :player1, :player2, :board
	def initialize (player1,player2)
		@player1 = Player.new("up", player1)
		@player2 = Player.new("down", player2)
		@board = Board.new
	end

	def move(from,to)
		if check(from,to)
			@board.gird[to[0]][to[1]].value = @board.gird[from[0]][from[1]].value
			@board.gird[from[0]][from[1]].value = "-"
		end
	end

	def check(from,to)
		result = false
		case @board.gird[from[0]][from[1]].value
		when "c"||"C"
			result = true if check_che(from, to)
		when "m"||"M"
			result = true if check_ma(from, to)
		when "x"||"X"
			result = true if check_xiang(from, to)
		when "s"||"S"
			result = true if check_shi(from, to)
		when "j"||"J"
			result = true if check_jiang(from, to)
		when "p"||"P"
			result = true if check_pao(from, to)
		when "b"||"B"
			result = true if check_bing(from, to)
		else
			result = false 
		end
	end

	def check_che(from,to)
		if from[0] == to[0]
			if from[1]>to[1]
				from[1],to[1] = to[1], from[1]
			end
			if @board.gird[from[0]][from[1]+1] == @board.gird[to[0]][to[1]-1]
				return eat(from,to) 
			else
				@board.gird[from[0]][(from[1]+1)..(to[1]-1)].each do |n|
					return false if n.value != "-"
				end
				return eat(from,to)
			end
		elsif from[1] == to[1]
			if from[0]>to[0]
				from[0],to[0] = to[0], from[0]
			end
			if @board.gird[from[0]+1][from[1]] == @board.gird[to[0]-1][to[1]]
				return eat(from,to) 
			else
				@board.gird[(from[0]+1)..(to[0]-1)].each do |n|
					return false if n[from[1]].value != "-"
				end
				return eat(from,to)
			end
		else
			return false
		end
	end

	def check_ma(from,to)
		case [to[0]][to[1]]
		when [from[0]-1][from[1]-2]
			@board.gird[from[0]][from[1]-1].value == "-" ? eat(from,to) : false
		when [from[0]+1][from[1]-2]
			@board.gird[from[0]][from[1]-1].value == "-" ? eat(from,to) : false
		when [from[0]+2][from[1]-1]
			@board.gird[from[0]+1][from[1]].value == "-" ? eat(from,to) : false
		when [from[0]+2][from[1]+1] 
			@board.gird[from[0]+1][from[1]].value == "-" ? eat(from,to) : false
		when [from[0]+1][from[1]+2]
			@board.gird[from[0]][from[1]+1].value == "-" ? eat(from,to) : false
		when [from[0]-1][from[1]+2]
			@board.gird[from[0]][from[1]+1].value == "-" ? eat(from,to) : false
		when [from[0]-2][from[1]-1]
			@board.gird[from[0]-1][from[1]].value == "-" ? eat(from,to) : false
		when [from[0]-1][from[1]+1]
			@board.gird[from[0]-1][from[1]].value == "-" ? eat(from,to) : false
		else
			return false
		end
	end

	def check_xiang(from,to)
		if @board.gird[from[0]][from[1]].value.downcase == @board.gird[from[0]][from[1]].value
			return false if to[1]<5
		else
			return false if to[1]>4
		end
 		case [to[0]][to[1]]
 		when [from[0]-2][from[1]-2]
 			@board.gird[from[0]-1][from[1]-1].value == "-" ? eat(from,to) : true
 		when [from[0]+2][from[1]-2]
 			@board.gird[from[0]+1][from[1]-1].value == "-" ? eat(from,to) : false
 		when [from[0]+2][from[1]+2]
 			@board.gird[from[0]+1][from[1]+1].value == "-" ? eat(from,to) : false
 		when [from[0]-2][from[1]+2]
 			@board.gird[from[0]-1][from[1]+1].value == "-" ? eat(from,to) : false
 		else
 			return false
 		end
	end

	def eat(from,to)
		if @board.gird[to[0]][to[1]].value == "-"
			return true
		elsif @board.gird[from[0]][from[1]].value.downcase == @board.gird[from[0]][from[1]].value
			if @board.gird[to[0]][to[1]].value.downcase == @board.gird[to[0]][to[1]].value
				return false
			else
				return true
			end
		else
			if @board.gird[to[0]][to[1]].value.upcase == @board.gird[to[0]][to[1]].value
				return false
			else
				return true
			end
		end
	end


end


board = Board.new
#board.setup
board.display