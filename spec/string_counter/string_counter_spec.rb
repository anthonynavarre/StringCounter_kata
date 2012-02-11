require 'spec_helper'

describe 'String Calculator' do

  describe '#add' do

    context 'when dealing with an empty string' do
      subject { '' }
      its(:add) { should == 0 }
    end

    context 'when dealing with a string with a single number' do

      context '"1", for instance' do
        subject { '1' }
        its(:add) { should == 1 }
      end

      context '"25", for instance' do
        subject { '25' }
        its(:add) { should == 25 }
      end

    end

    context 'when dealing with more than 1 number' do

      context '"1,2", for instance' do
        subject { '1,2' }
        its(:add) { should == 3 }
      end

      context '"1,2,3", for instance' do
        subject { '1,2,3' }
        its(:add) { should == 6 }
      end

    end

    context 'when using newline-characters as separators' do

      context '"1\n2,3", for instance' do
        subject { "1\n2,3" }
        its(:add) { should == 6 }
      end

    end
  end
end

