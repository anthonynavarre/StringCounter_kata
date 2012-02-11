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

    context 'when dealing with more than 1 number' do

      it 'returns the sum of 2 numbers' do
        '1,2'.add.should == 3
      end

      it 'returns the sum of 3 numbers' do
        '1,2,3'.add.should == 6
      end
    end

    context 'when using special characters as separators' do

      it "treats newline characters (\\n) the same as commas" do
       "1\n2,3".add.should == 6 
      end
    end
  end
end

