require 'spec_helper'

describe 'String Calculator' do

  describe '#add' do

    it 'returns 0 (Int) when dealing w/ an empty string' do
      ''.add.should == 0
    end

    context "a string with a single number" do

      it "returns the number" do
        3.times do |i|
          i.to_s.add.should == i
        end
      end
    end

  end
end

