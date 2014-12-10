require 'spec_helper'

describe Game do
	before do
		@test_game = Game.new "Peter", "Jojo"
	end

	describe "#eat" do
		it "return ture if opponent" do
			expect(@test_game.eat([3,0],[3,9])).to eql(true)
		end
		it "return false if self" do
			expect(@test_game.eat([0,3],[0,0])).to eql(false)
		end
	end

	describe "#check_che" do
		before do
			@test_game.board.gird[8][3].value = "-"
			@test_game.board.gird[7][0].value = "-"
			@test_game.board.gird[6][0].value = "x"
		end
		it "return false, bin in between (ver)" do 
			expect(@test_game.check_che([0,0],[0,6])).to eql(false)
		end

		it "return ture, nothing inbetween (ver)" do
			expect(@test_game.check_che([8,6],[8,0])).to eql(true)
		end

		it "return false, bin in between (hor)" do 
			expect(@test_game.check_che([0,0],[2,0])).to eql(false)
		end

		it "return ture, nothing inbetween(hor)" do
			expect(@test_game.check_che([8,0],[6,0])).to eql(true)
		end

	end

	describe "#check_ma" do
		it "return false, something in between" do
			expect(@test_game.check_ma([1,0],[3,1])).to eql(false)
		end
		it "return ture, nothing in between " do
			expect(@test_game.check_ma([1,9],[0,7])).to eql(true)
		end

	end

	describe "#check_xiang" do
		it "rerurn ture nothing in between" do
			expect(@test_game.check_xiang([2,0],[0,2])).to eql(true)
		end
	end

end