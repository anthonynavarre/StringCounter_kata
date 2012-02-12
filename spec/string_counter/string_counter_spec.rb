require 'spec_helper'

describe 'String Calculator' do

  describe '#add' do
    describe "when dealing with:" do

      context 'an empty string' do
        subject { '' }
        its(:add) { should == 0 }
      end

      context 'a string with a single number' do

        context '"1", for instance' do
          subject { '1' }
          its(:add) { should == 1 }
        end

        context '"25", for instance' do
          subject { '25' }
          its(:add) { should == 25 }
        end

      end

      context 'more than 1 number' do

        context '"1,2", for instance' do
          subject { '1,2' }
          its(:add) { should == 3 }
        end

        context '"1,2,3", for instance' do
          subject { '1,2,3' }
          its(:add) { should == 6 }
        end

      end

      context 'newline-characters as separators' do

        context '"1\n2,3", for instance' do
          subject { "1\n2,3" }
          its(:add) { should == 6 }
        end

      end

      context 'a custom delimiter' do

        context '"//;\n1;2", for instance' do
          subject { "//;\n1;2" }
          its(:add) { should == 3 }
        end

      end

      context 'negative numbers' do

        context '"-1" for instance' do
          subject { "-1" }

          it 'raises an ArgumentError' do
            expect{ subject.add }.should raise_error(ArgumentError, /Negatives not allowed/)
          end

          it 'contains some helpful information in its error message' do
            expect{ subject.add }.should raise_error(ArgumentError, /Passed negatives: -1/)
          end
        end

        context '"-1, 2, -3" for instance' do
          subject { "-1, 2, -3" }

          it 'raises an ArgumentError' do
            expect{ subject.add }.should raise_error(ArgumentError, /Negatives not allowed/)
          end

          it 'contains some helpful information in its error message' do
            expect{ subject.add }.should raise_error(ArgumentError, %r(Passed negatives: -1,-3))
          end
        end

      end
    end
  end
end

