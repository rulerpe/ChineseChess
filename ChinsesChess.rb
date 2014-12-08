class Cell
	attr_accessor :value
	def initialize (value)
		@value = value
	end
end

class Board
	attr_accessor :gird
	def initialize
		@grid = default_gird
		setup
	end

	def default_gird
		Array.new(9){ Array.new(10) { Cell.new("-")}}
	end

	def setup
		bottom = ["C","M","X","S","J","S","X","M","C"]	
		@grid.each_index do |x|
			@grid[x][0].value = bottom[x]
			@grid[x][9].value = bottom[x].downcase
			if [0,2,4,6,8].include?(x)
				@grid[x][3].value = "B"
				@grid[x][6].value = "b"
			end
		end
		@grid[1][2].value ="P"
		@grid[7][2].value ="P"

		@grid[1][7].value ="p"
		@grid[7][7].value ="p"
	end

	def display
		puts "1 2 3 4 5 6 7 8 9"
		@grid[0].each_index do |y|
			@grid.each_index do |x|
				print @grid[x][y].value + " "
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
		@player1 = Player.new("X", player1)
		@player2 = Player.new("O", player2)
		@board = Board.new
	end

	def move(from,to)
		if check(from,to)
			@board.gird[to[0]][to[1]].value = @board.grid[from[0]][from[1]].value
			@board.grid[from[0]][from[1]].value = "-"
		end
	end

	def check(from,to)
		result = false
		case @board.grid[from[0]][from[1]].value
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
			if @board.gird[from[0]][from[1]+1]
		elsif from[1] == to[1]

		end
	end


end


board = Board.new
#board.setup
board.display