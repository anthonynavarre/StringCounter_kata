require 'spec_helper'

describe 'String Calculator' do

  describe '#add' do

    it 'returns 0 (Int) when dealing w/ an empty string' do
      ''.add.should == 0
    end

    context "a string with a single number" do

      it "returns the number" do
        '1'.add.should == 1
      end
    end

    context 'when dealing with more than 1 digit' do

      it 'returns the sum of its parts' do
        '1,2'.add.should == 3
      end

    end

  end
end

