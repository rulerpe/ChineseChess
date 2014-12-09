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
		it "return false, bin in between" do 
			expect(@test_game.check_che([0,0],[0,6])).to eql(false)
		end

		it "return ture, nothing inbetween" do
			expect(@test_game.check_che([8,6],[8,0])).to eql(true)
		end

		it "return false, bin in between" do 
			expect(@test_game.check_che([0,0],[2,0])).to eql(false)
		end

		it "return ture, nothing inbetween" do
			expect(@test_game.check_che([8,0],[6,0])).to eql(true)
		end

	end

end