require 'spec_helper'

describe 'String Calculator' do

  describe '#add' do

    it 'returns 0 (Int) when dealing w/ an empty string' do
      ''.add.should == 0
    end

  end
end

