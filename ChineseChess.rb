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
		i = 0
		puts "  0 1 2 3 4 5 6 7 8"
		@gird[0].each_index do |y|
			print "#{i} "
			@gird.each_index do |x|
				print @gird[x][y].value + " "
			end
			puts ""
			i+=1
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

	def play
		curr_player = @player2
		@board.display
		while won(curr_player)
			if curr_player == @player1
				curr_player = @player2
			else
				curr_player = @player1
			end
			puts "#{curr_player.name} enter your move"
			print "from:"
			from = gets.chomp
			print "to"
			to = gets.chomp
			from = from.split(",")
			from[0] = from[0].to_i
			from[1] = from[1].to_i
			to = to.split(",")
			to[0] = to[0].to_i
			to[1] = to[1].to_i
			move(from,to)
			@board.display

		end
		@board.display
		prints "#{curr_player.name} win"
	end

	def won(curr_player)
		curr_board = @board.gird.flatten
		if curr_player.color == "up"
			curr_board.each do |n|
				return true if n.value == "J"
			end
		elsif curr_player.color == "down"
			curr_board.each do |n|
				return true if n.value == "j"
			end
		end
		return false
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
		fromx,tox = from.dup,to.dup
		if from[0] == to[0]
			if from[1]>to[1]
				from[1],to[1] = to[1], from[1]
			end
			if @board.gird[from[0]][from[1]+1] == @board.gird[to[0]][to[1]-1]
				return eat(fromx,tox) 
			else
				@board.gird[from[0]][(from[1]+1)..(to[1]-1)].each do |n|
					return false if n.value != "-"
				end
				return eat(fromx,tox)
			end
		elsif from[1] == to[1]
			if from[0]>to[0]
				from[0],to[0] = to[0], from[0]
			end
			if @board.gird[from[0]+1][from[1]] == @board.gird[to[0]-1][to[1]]
				return eat(fromx,tox) 
			else
				@board.gird[(from[0]+1)..(to[0]-1)].each do |n|
					return false if n[from[1]].value != "-"
				end
				return eat(fromx,tox)
			end
		else
			return false
		end
	end

	def check_ma(from,to)
		case to
		when [from[0]-1,from[1]-2]
			@board.gird[from[0]][from[1]-1].value == "-" ? eat(from,to) : false
		when [from[0]+1,from[1]-2]
			@board.gird[from[0]][from[1]-1].value == "-" ? eat(from,to) : false
		when [from[0]+2,from[1]-1]
			@board.gird[from[0]+1][from[1]].value == "-" ? eat(from,to) : false
		when [from[0]+2,from[1]+1] 
			@board.gird[from[0]+1][from[1]].value == "-" ? eat(from,to) : false
		when [from[0]+1,from[1]+2]
			@board.gird[from[0]][from[1]+1].value == "-" ? eat(from,to) : false
		when [from[0]-1,from[1]+2]
			@board.gird[from[0]][from[1]+1].value == "-" ? eat(from,to) : false
		when [from[0]-2,from[1]-1]
			@board.gird[from[0]-1][from[1]].value == "-" ? eat(from,to) : false
		when [from[0]-1,from[1]+1]
			@board.gird[from[0]-1][from[1]].value == "-" ? eat(from,to) : false
		else
			return false
		end
	end

	def check_xiang(from,to)
		if @board.gird[from[0]][from[1]].value.downcase == @board.gird[from[0]][from[1]].value
			return false if to[1]<5
		elsif @board.gird[from[0]][from[1]].value.upcase == @board.gird[from[0]][from[1]].value
			return false if to[1]>4
		end
 		case to
 		when [from[0]-2,from[1]-2]
 			@board.gird[from[0]-1][from[1]-1].value == "-" ? eat(from,to) : false
 		when [from[0]+2,from[1]-2]
 			@board.gird[from[0]+1][from[1]-1].value == "-" ? eat(from,to) : false
 		when [from[0]+2,from[1]+2]
 			@board.gird[from[0]+1][from[1]+1].value == "-" ? eat(from,to) : false
 		when [from[0]-2,from[1]+2]
 			@board.gird[from[0]-1][from[1]+1].value == "-" ? eat(from,to) : false
 		else
 			return false
 		end
	end

	def check_shi(from,to)
		if 5<to[0] || to[0]<3
			return false
		end
		if @board.gird[from[0]][from[1]].value.downcase == @board.gird[from[0]][from[1]].value
			return false if to[1]<7
		elsif @board.gird[from[0]][from[1]].value.upcase == @board.gird[from[0]][from[1]].value
			return false if to[1]>2
		end

		if (from[0]-to[0]).abs == 1 && (from[1]-to[1]).abs == 1
			return eat(from,to)
		else
			return false
		end

	end

	def check_jiang(from,to)
		if 5<to[0] || to[0]<3
			return false
		end
		if @board.gird[from[0]][from[1]].value.downcase == @board.gird[from[0]][from[1]].value
			return false if to[1]<7
		elsif @board.gird[from[0]][from[1]].value.upcase == @board.gird[from[0]][from[1]].value
			return false if to[1]>2
		end

		if (from[0]-to[0]).abs + (from[1]-to[1]).abs == 1
			return eat(from,to)
		else
			return false
		end

	end

	def check_pao(from,to)
		fromx,tox = from.dup,to.dup
		if from[0]==to[0]
			if from[1]>to[1]
				from[1],to[1] = to[1], from[1]
			end
			if to[1] - from[1] == 1
				@board.gird[tox[0]][tox[1]].value == "-" ? true : false
			else
				i = 0
				@board.gird[from[0]][(from[1]+1)..(to[1]-1)].each do |n|
					i+=1 if n.value != "-"
				end
				if i == 1
					return pao_eat(fromx,tox)
				elsif i == 0
					@board.gird[tox[0]][tox[1]].value == "-" ? true : false
				else
					return false
				end
			end
		elsif from[1]==to[1]
			if from[0]>to[0]
				from[0],to[0] = to[0], from[0]
			end
			if to[0] - from[0] == 1
				@board.gird[tox[0]][tox[1]].value == "-" ? true : false 
			else
				i = 0
				@board.gird[(from[0]+1)..(to[0]-1)].each do |n|
					i+=1 if n[from[1]].value != "-"
				end
				if i == 1
					return pao_eat(fromx,tox)
				elsif i == 0
					@board.gird[tox[0]][tox[1]].value == "-" ? true : false
				else
					return false
				end
			end
		else
			return false
		end
	end

	def check_bing(from,to)
		if @board.gird[from[0]][from[1]].value.downcase == @board.gird[from[0]][from[1]].value
			return false if to[1]-from[1]==1
			return false if from[1]>4 && to[0]-from[0]!= 0
		elsif @board.gird[from[0]][from[1]].value.upcase == @board.gird[from[0]][from[1]].value
			return false if from[1]-to[1]==1
			return false if from[1]<5 && to[0]-from[0]!= 0
		end

		if from[0]-to[0] == 1 || from[0]-to[0] == -1
			from[1]-to[1] == 0 ? eat(from,to) : false
		elsif from[1]-to[1] == 1 || from[1]-to[1] == -1
			from[0]-to[0] == 0 ? eat(from,to) : false
		else
			false
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

	def pao_eat(from,to)
		if @board.gird[to[0]][to[1]].value == "-"
			return false
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


game = Game.new("peter","jojo")
#board.setup
game.play