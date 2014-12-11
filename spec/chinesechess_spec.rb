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
		it "return ture" do
			expect(@test_game.check_ma([7,9],[6,7])).to eql(true)
		end
		it "return false" do
			expect(@test_game.check_ma([7,9],[5,8])).to eql(false)
		end

	end

	describe "#check_xiang" do
		before do
			@test_game.board.gird[3][2].value = "X"
			@test_game.board.gird[1][0].value = "m"
		end
		it "rerurn ture nothing in between" do
			expect(@test_game.check_xiang([2,0],[0,2])).to eql(true)
		end
		it "return false something in between" do
			expect(@test_game.check_xiang([3,2],[1,4])).to eql(false)
		end
		it "return true nothing in between and eat" do
			expect(@test_game.check_xiang([3,2],[1,0])).to eql(true)
		end

	end

	describe "#check_shi" do
		it "return true inbound right diangle move" do
			expect(@test_game.check_shi([3,0],[4,1])).to eql(true)
		end
		it "return true inbound right diangle move" do
			expect(@test_game.check_shi([3,9],[4,8])).to eql(true)
		end
		it "return false out bound" do
			expect(@test_game.check_shi([3,0],[2,1])).to eql(false)
		end
		it "return false step to far" do
			expect(@test_game.check_shi([3,0],[5,2])).to eql(false)
		end

	end

	describe "#check_jiang" do
		before do
			@test_game.board.gird[4][2].value = "m"
			@test_game.board.gird[3][2].value = "J"
		end
		it "return true inbound right ver move" do
			expect(@test_game.check_jiang([4,0],[4,1])).to eql(true)
		end
		it "return true inbound right hor move" do
			expect(@test_game.check_jiang([3,2],[4,2])).to eql(true)
		end
		it "return false out bound" do
			expect(@test_game.check_jiang([3,2],[2,2])).to eql(false)
		end
		it "return false step to far" do
			expect(@test_game.check_jiang([3,2],[3,3])).to eql(false)
		end

	end


	describe "#check_pao" do
		it "return ture nothing in between and on the spot" do
			expect(@test_game.check_pao([1,2],[1,3])).to eql(true)
		end
		it "return ture one piece in between and oppent on the spot" do
			expect(@test_game.check_pao([1,7],[1,0])).to eql(true)
		end
		it "return false nothing in between and one piece on the spot" do
			expect(@test_game.check_pao([7,2],[1,2])).to eql(false)
		end
		it "return false one piece in between and nothing on the spot" do
			expect(@test_game.check_pao([7,7],[0,7])).to eql(false)
		end
	end

end