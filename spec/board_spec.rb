# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/checker'

describe Board do
  describe '#win?' do
    context 'when there are four red checkers in a row horizontally' do
      let(:checker31) { instance_double(Checker, color: :red, x: 3, y: 1) }
      let(:checker32) { instance_double(Checker, color: :red, x: 3, y: 2) }
      let(:checker33) { instance_double(Checker, color: :red, x: 3, y: 3) }
      let(:checker34) { instance_double(Checker, color: :red, x: 3, y: 4) }
      let(:values) { 
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, checker31, checker32, checker33, checker34, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:horizontal_red_win) { described_class.new(values) }
      it 'is a win' do
        last_placed_checker = checker33
        expect(horizontal_red_win).to be_win(last_placed_checker)
      end
    end

    context 'when there are four yellow checkers in a row horizontally' do
      let(:checker03) { instance_double(Checker, color: :yellow, x: 0, y: 3) }
      let(:checker04) { instance_double(Checker, color: :yellow, x: 0, y: 4) }
      let(:checker05) { instance_double(Checker, color: :yellow, x: 0, y: 5) }
      let(:checker06) { instance_double(Checker, color: :yellow, x: 0, y: 6) }
      let(:values) {
        [[nil, nil, nil, checker03, checker04, checker05, checker06], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:horizontal_yellow_win) { described_class.new(values) }
      it 'is a win' do
        last_placed_checker = checker06
        expect(horizontal_yellow_win).to be_win(last_placed_checker)
      end
    end

    context 'when there are three red checkers in a row horizontally' do
      let(:checker10) { instance_double(Checker, color: :red, x: 1, y: 0) }
      let(:checker11) { instance_double(Checker, color: :red, x: 1, y: 1) }
      let(:checker12) { instance_double(Checker, color: :red, x: 1, y: 2) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [checker10, checker11, checker12, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:horizontal_red_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker10
        expect(horizontal_red_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are three yellow checkers in a row horizontally' do
      let(:checker42) { instance_double(Checker, color: :yellow, x: 4, y: 2) }
      let(:checker43) { instance_double(Checker, color: :yellow, x: 4, y: 3) }
      let(:checker44) { instance_double(Checker, color: :yellow, x: 4, y: 4) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, checker42, checker43, checker44, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:horizontal_yellow_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker43
        expect(horizontal_yellow_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are four red checkers horizontally but they are not in a row' do
      let(:checker51) { instance_double(Checker, color: :red, x: 5, y: 1) }
      let(:checker52) { instance_double(Checker, color: :red, x: 5, y: 2) }
      let(:checker53) { instance_double(Checker, color: :red, x: 5, y: 3) }
      let(:checker55) { instance_double(Checker, color: :red, x: 5, y: 5) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, checker51, checker52, checker53, nil, checker55, nil]]
      }
      subject(:horizontal_red_four_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker55
        expect(horizontal_red_four_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are four yellow checkers horizontally but they are not in a row' do
      subject(:horizontal_yellow_four_loss) { described_class.new(values) }
      let(:checker30) { instance_double(Checker, color: :yellow, x: 3, y: 0) }
      let(:checker32) { instance_double(Checker, color: :yellow, x: 3, y: 2) }
      let(:checker33) { instance_double(Checker, color: :yellow, x: 3, y: 3) }
      let(:checker34) { instance_double(Checker, color: :yellow, x: 3, y: 4) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [checker30, nil, checker32, checker33, checker34, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      it 'is not a win' do
        last_placed_checker = checker33
        expect(horizontal_yellow_four_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are four checkers in a row horizontally but they are not all the same color' do
      let(:checker51) { instance_double(Checker, color: :yellow, x: 5, y: 1) }
      let(:checker52) { instance_double(Checker, color: :yellow, x: 5, y: 2) }
      let(:checker53) { instance_double(Checker, color: :red, x: 5, y: 3) }
      let(:checker54) { instance_double(Checker, color: :yellow, x: 5, y: 4) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, checker51, checker52, checker53, checker54, nil, nil]]
      }
      subject(:horizontal_mixed_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker53
        expect(horizontal_mixed_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are four red checkers in a row vertically' do
      let(:checker11) { instance_double(Checker, color: :red, x: 1, y: 1) }
      let(:checker21) { instance_double(Checker, color: :red, x: 2, y: 1) }
      let(:checker31) { instance_double(Checker, color: :red, x: 3, y: 1) }
      let(:checker41) { instance_double(Checker, color: :red, x: 4, y: 1) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, checker11, nil, nil, nil, nil, nil],
        [nil, checker21, nil, nil, nil, nil, nil],
        [nil, checker31, nil, nil, nil, nil, nil],
        [nil, checker41, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:vertical_red_win) { described_class.new(values) }
      it 'is a win' do
        last_placed_checker = checker11
        expect(vertical_red_win).to be_win(last_placed_checker)
      end
    end

    context 'when there are four yellow checkers in a row vertically' do
      let(:checker05) { instance_double(Checker, color: :yellow, x: 0, y: 5) }
      let(:checker15) { instance_double(Checker, color: :yellow, x: 1, y: 5) }
      let(:checker25) { instance_double(Checker, color: :yellow, x: 2, y: 5) }
      let(:checker35) { instance_double(Checker, color: :yellow, x: 3, y: 5) }
      let(:values) {
        [[nil, nil, nil, nil, nil, checker05, nil], 
        [nil, nil, nil, nil, nil, checker15, nil],
        [nil, nil, nil, nil, nil, checker25, nil],
        [nil, nil, nil, nil, nil, checker35, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:vertical_yellow_win) { described_class.new(values) }
      it 'is a win' do
        last_placed_checker = checker05
        expect(vertical_yellow_win).to be_win(last_placed_checker)
      end
    end

    context 'when there are three red checkers in a row vertically' do
      let(:checker00) { instance_double(Checker, color: :red, x: 0, y: 0) }
      let(:checker10) { instance_double(Checker, color: :red, x: 1, y: 0) }
      let(:checker20) { instance_double(Checker, color: :red, x: 2, y: 0) }
      let(:values) { 
        [[checker00, nil, nil, nil, nil, nil, nil], 
        [checker10, nil, nil, nil, nil, nil, nil],
        [checker20, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:vertical_red_loss) { described_class.new(values) }
      it 'is not a win' do            
        last_placed_checker = checker00
        expect(vertical_red_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are three yellow checkers in a row vertically' do
      let(:checker35) { instance_double(Checker, color: :yellow, x: 3, y: 5) }
      let(:checker45) { instance_double(Checker, color: :yellow, x: 4, y: 5) }
      let(:checker55) { instance_double(Checker, color: :yellow, x: 5, y: 5) }
      let(:values) { 
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, checker35, nil],
        [nil, nil, nil, nil, nil, checker45, nil],
        [nil, nil, nil, nil, nil, checker55, nil]]
      }
      subject(:vertical_yellow_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker35
        expect(vertical_yellow_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are 4 red checkers vertically but they are not in a row' do
      let(:checker12) { instance_double(Checker, color: :red, x: 1, y: 2) }
      let(:checker22) { instance_double(Checker, color: :red, x: 2, y: 2) }
      let(:checker32) { instance_double(Checker, color: :red, x: 3, y: 2) }
      let(:checker52) { instance_double(Checker, color: :red, x: 5, y: 2) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, checker12, nil, nil, nil, nil],
        [nil, nil, checker22, nil, nil, nil, nil],
        [nil, nil, checker32, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, checker52, nil, nil, nil, nil]]
      }
      subject(:vertical_red_four_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker12
        expect(vertical_red_four_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are 4 yellow checkers vertically but they are not in a row' do
      let(:checker06) { instance_double(Checker, color: :yellow, x: 0, y: 6) }
      let(:checker26) { instance_double(Checker, color: :yellow, x: 2, y: 6) }
      let(:checker36) { instance_double(Checker, color: :yellow, x: 3, y: 6) }
      let(:checker46) { instance_double(Checker, color: :yellow, x: 4, y: 6) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, checker06], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, checker26],
        [nil, nil, nil, nil, nil, nil, checker36],
        [nil, nil, nil, nil, nil, nil, checker46],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:vertical_yellow_four_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker06
        expect(vertical_yellow_four_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are 4 yellow checkers vertically but they are not in a row' do
      let(:checker06) { instance_double(Checker, color: :yellow, x: 0, y: 6) }
      let(:checker26) { instance_double(Checker, color: :yellow, x: 2, y: 6) }
      let(:checker36) { instance_double(Checker, color: :yellow, x: 3, y: 6) }
      let(:checker46) { instance_double(Checker, color: :yellow, x: 4, y: 6) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, checker06], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, checker26],
        [nil, nil, nil, nil, nil, nil, checker36],
        [nil, nil, nil, nil, nil, nil, checker46],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:vertical_yellow_four_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker06
        expect(vertical_yellow_four_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are 4 checkers in a row vertically but they are not all the same color' do
      let(:checker21) { instance_double(Checker, color: :yellow, x: 2, y: 1) }
      let(:checker31) { instance_double(Checker, color: :red, x: 3, y: 1) }
      let(:checker41) { instance_double(Checker, color: :red, x: 4, y: 1) }
      let(:checker51) { instance_double(Checker, color: :red, x: 5, y: 1) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, checker21, nil, nil, nil, nil, nil],
        [nil, checker31, nil, nil, nil, nil, nil],
        [nil, checker41, nil, nil, nil, nil, nil],
        [nil, checker51, nil, nil, nil, nil, nil]]
      }
      subject(:vertical_yellow_four_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker21
        expect(vertical_yellow_four_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are 4 red checkers in a row diagonally from left to right' do
      let(:checker02) { instance_double(Checker, color: :red, x: 0, y: 2) }
      let(:checker13) { instance_double(Checker, color: :red, x: 1, y: 3) }
      let(:checker24) { instance_double(Checker, color: :red, x: 2, y: 4) }
      let(:checker35) { instance_double(Checker, color: :red, x: 3, y: 5) }
      let(:values) {
        [[nil, nil, checker02, nil, nil, nil, nil], 
        [nil, nil, nil, checker13, nil, nil, nil],
        [nil, nil, nil, nil, checker24, nil, nil],
        [nil, nil, nil, nil, nil, checker35, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:left_right_diag_red_win) { described_class.new(values) }
      it 'is a win' do
        last_placed_checker = checker24
        expect(left_right_diag_red_win).to be_win(last_placed_checker)
      end
    end

    context 'when there are 4 yellow checkers in a row diagonally from left to right' do
      let(:checker21) { instance_double(Checker, color: :yellow, x: 2, y: 1) }
      let(:checker32) { instance_double(Checker, color: :yellow, x: 3, y: 2) }
      let(:checker43) { instance_double(Checker, color: :yellow, x: 4, y: 3) }
      let(:checker54) { instance_double(Checker, color: :yellow, x: 5, y: 4) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, checker21, nil, nil, nil, nil, nil],
        [nil, nil, checker32, nil, nil, nil, nil],
        [nil, nil, nil, checker43, nil, nil, nil],
        [nil, nil, nil, nil, checker54, nil, nil]]
      }
      subject(:left_right_diag_yellow_win) { described_class.new(values) }
      it 'is a win' do
        last_placed_checker = checker54
        expect(left_right_diag_yellow_win).to be_win(last_placed_checker)
      end
    end

    context 'when there are 3 red checkers in a row diagonally from left to right' do
      let(:checker34) { instance_double(Checker, color: :red, x: 3, y: 4) }
      let(:checker45) { instance_double(Checker, color: :red, x: 4, y: 5) }
      let(:checker56) { instance_double(Checker, color: :red, x: 5, y: 6) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, checker34, nil, nil],
        [nil, nil, nil, nil, nil, checker45, nil],
        [nil, nil, nil, nil, nil, nil, checker56]]
      }
      subject(:left_right_diag_red_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker34
        expect(left_right_diag_red_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are 3 yellow checkers in a row diagonally from left to right' do
      let(:checker20) { instance_double(Checker, color: :yellow, x: 2, y: 0) }
      let(:checker31) { instance_double(Checker, color: :yellow, x: 3, y: 1) }
      let(:checker42) { instance_double(Checker, color: :yellow, x: 4, y: 2) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil, nil],
        [checker20, nil, nil, nil, nil, nil, nil],
        [nil, checker31, nil, nil, nil, nil, nil],
        [nil, nil, checker42, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:left_right_diag_yellow_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker31
        expect(left_right_diag_yellow_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are 4 checkers in a row diagonally from left to right but they are not all the same color' do
      let(:checker02) { instance_double(Checker, color: :red, x: 0, y: 2) }
      let(:checker13) { instance_double(Checker, color: :yellow, x: 1, y: 3) }
      let(:checker24) { instance_double(Checker, color: :red, x: 2, y: 4) }
      let(:checker35) { instance_double(Checker, color: :yellow, x: 3, y: 5) }
      let(:values) {
        [[nil, nil, checker02, nil, nil, nil, nil], 
        [nil, nil, nil, checker13, nil, nil, nil],
        [nil, nil, nil, nil, checker24, nil, nil],
        [nil, nil, nil, nil, nil, checker35, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:left_right_diag_mixed_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker13
        expect(left_right_diag_mixed_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are 4 red checkers in a row diagonally from right to left' do
      let(:checker14) { instance_double(Checker, color: :red, x: 1, y: 4) }
      let(:checker23) { instance_double(Checker, color: :red, x: 2, y: 3) }
      let(:checker32) { instance_double(Checker, color: :red, x: 3, y: 2) }
      let(:checker41) { instance_double(Checker, color: :red, x: 4, y: 1) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, checker14, nil, nil],
        [nil, nil, nil, checker23, nil, nil, nil],
        [nil, nil, checker32, nil, nil, nil, nil],
        [nil, checker41, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:right_left_diag_red_win) { described_class.new(values) }
      it 'is a win' do
        last_placed_checker = checker41
        expect(right_left_diag_red_win).to be_win(last_placed_checker)
      end
    end

    context 'when there are 4 yellow checkers in a row diagonally from right to left' do
      let(:checker03) { instance_double(Checker, color: :yellow, x: 0, y: 3) }
      let(:checker12) { instance_double(Checker, color: :yellow, x: 1, y: 2) }
      let(:checker21) { instance_double(Checker, color: :yellow, x: 2, y: 1) }
      let(:checker30) { instance_double(Checker, color: :yellow, x: 3, y: 0) }
      let(:values) {
        [[nil, nil, nil, checker03, nil, nil, nil], 
        [nil, nil, checker12, nil, nil, nil, nil],
        [nil, checker21, nil, nil, nil, nil, nil],
        [checker30, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:right_left_diag_yellow_win) { described_class.new(values) }
      it 'is a win' do
        last_placed_checker = checker21
        expect(right_left_diag_yellow_win).to be_win(last_placed_checker)
      end
    end

    context 'when there are 3 red checkers in a row diagonally from right to left' do
      let(:checker36) { instance_double(Checker, color: :red, x: 3, y: 6) }
      let(:checker45) { instance_double(Checker, color: :red, x: 4, y: 5) }
      let(:checker54) { instance_double(Checker, color: :red, x: 5, y: 4) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, checker36],
        [nil, nil, nil, nil, nil, checker45, nil],
        [nil, nil, nil, nil, checker54, nil, nil]]
      }
      subject(:right_left_diag_red_loss) { described_class.new(values) }
      it 'is not a win' do           
        last_placed_checker = checker45
        expect(right_left_diag_red_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are 3 yellow checkers in a row diagonally from right to left' do
      let(:checker24) { instance_double(Checker, color: :yellow, x: 2, y: 4) }
      let(:checker33) { instance_double(Checker, color: :yellow, x: 3, y: 3) }
      let(:checker42) { instance_double(Checker, color: :yellow, x: 4, y: 2) }
      let(:values) {
        [[nil, nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, checker24, nil, nil],
        [nil, nil, nil, checker33, nil, nil, nil],
        [nil, nil, checker42, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:right_left_diag_yellow_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker42
        expect(right_left_diag_yellow_loss).not_to be_win(last_placed_checker)
      end
    end

    context 'when there are 4 checkers in a row diagonally from right to left but they are not all the same color' do
      let(:checker04) { instance_double(Checker, color: :red, x: 0, y: 4) }
      let(:checker13) { instance_double(Checker, color: :yellow, x: 1, y: 3) }
      let(:checker22) { instance_double(Checker, color: :red, x: 2, y: 2) }
      let(:checker31) { instance_double(Checker, color: :yellow, x: 3, y: 1) }
      let(:values) {
        [[nil, nil, nil, nil, checker04, nil, nil], 
        [nil, nil, nil, checker13, nil, nil, nil],
        [nil, nil, checker22, nil, nil, nil, nil],
        [nil, checker31, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil]]
      }
      subject(:right_left_diag_mixed_loss) { described_class.new(values) }
      it 'is not a win' do
        last_placed_checker = checker13
        expect(right_left_diag_mixed_loss).not_to be_win(last_placed_checker)
      end
    end
  end
end

[[nil, nil, nil, nil, nil, nil, nil], 
[nil, nil, nil, nil, nil, nil, nil],
[nil, nil, nil, nil, nil, nil, nil],
[nil, nil, nil, nil, nil, nil, nil],
[nil, nil, nil, nil, nil, nil, 46],
[nil, nil, nil, nil, nil, 55, nil]]