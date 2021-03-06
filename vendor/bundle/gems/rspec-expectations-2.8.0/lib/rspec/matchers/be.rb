require 'rspec/matchers/dsl'

module RSpec
  module Matchers
    class BeTrue
      include BaseMatcher

      def matches?(actual)
        super(actual)
      end
    end

    # Passes if actual is truthy (anything but false or nil)
    def be_true
      BeTrue.new
    end

    class BeFalse
      include BaseMatcher

      def matches?(actual)
        !super(actual)
      end
    end

    # Passes if actual is falsy (false or nil)
    def be_false
      BeFalse.new
    end

    class BeNil
      include BaseMatcher

      def matches?(actual)
        super(actual).nil?
      end

      def failure_message_for_should
        "expected: nil\n     got: #{actual.inspect}"
      end

      def failure_message_for_should_not
        "expected: not nil\n     got: nil"
      end
    end

    # Passes if actual is nil
    def be_nil
      BeNil.new
    end

    class Be
      include RSpec::Matchers::Pretty
      
      def initialize(*args, &block)
        @args = args
      end
      
      def matches?(actual)
        @actual = actual
        !!@actual
      end

      def failure_message_for_should
        "expected #{@actual.inspect} to evaluate to true"
      end
      
      def failure_message_for_should_not
        "expected #{@actual.inspect} to evaluate to false"
      end
      
      def description
        "be"
      end

      [:==, :<, :<=, :>=, :>, :===].each do |operator|
        define_method operator do |operand|
          BeComparedTo.new(operand, operator)
        end
      end

    private

      def args_to_s
        @args.empty? ? "" : parenthesize(inspected_args.join(', '))
      end
      
      def parenthesize(string)
        "(#{string})"
      end
      
      def inspected_args
        @args.collect{|a| a.inspect}
      end
      
      def expected_to_sentence
        split_words(@expected)
      end
      
      def args_to_sentence
        to_sentence(@args)
      end
        
    end

    class BeComparedTo < Be

      def initialize(operand, operator)
        @expected, @operator = operand, operator
        @args = []
      end

      def matches?(actual)
        @actual = actual
        @actual.__send__(@operator, @expected)
      end

      def failure_message_for_should
        "expected: #{@operator} #{@expected.inspect}\n     got: #{@operator.to_s.gsub(/./, ' ')} #{@actual.inspect}"
      end
      
      def failure_message_for_should_not
        message = <<-MESSAGE
'should_not be #{@operator} #{@expected}' not only FAILED,
it is a bit confusing.
          MESSAGE
          
        raise message << ([:===,:==].include?(@operator) ?
          "It might be more clearly expressed without the \"be\"?" :
          "It might be more clearly expressed in the positive?")
      end

      def description
        "be #{@operator} #{expected_to_sentence}#{args_to_sentence}"
      end

    end

    class BePredicate < Be

      def initialize(*args, &block)
        @expected = parse_expected(args.shift)
        @args = args
        @block = block
      end
      
      def matches?(actual)
        @actual = actual
        begin
          return @result = actual.__send__(predicate, *@args, &@block)
        rescue NameError => predicate_missing_error
          "this needs to be here or rcov will not count this branch even though it's executed in a code example"
        end

        begin
          return @result = actual.__send__(present_tense_predicate, *@args, &@block)
        rescue NameError
          raise predicate_missing_error
        end
      end
      
      def failure_message_for_should
        "expected #{predicate}#{args_to_s} to return true, got #{@result.inspect}"
      end
      
      def failure_message_for_should_not
        "expected #{predicate}#{args_to_s} to return false, got #{@result.inspect}"
      end

      def description
        "#{prefix_to_sentence}#{expected_to_sentence}#{args_to_sentence}"
      end

    private

      def predicate
        "#{@expected}?".to_sym
      end
      
      def present_tense_predicate
        "#{@expected}s?".to_sym
      end
      
      def parse_expected(expected)
        @prefix, expected = prefix_and_expected(expected)
        expected
      end

      def prefix_and_expected(symbol)
        symbol.to_s =~ /^(be_(an?_)?)(.*)/
        return $1, $3
      end

      def prefix_to_sentence
        split_words(@prefix)
      end

    end

    # @example
    #   actual.should be_true
    #   actual.should be_false
    #   actual.should be_nil
    #   actual.should be_[arbitrary_predicate](*args)
    #   actual.should_not be_nil
    #   actual.should_not be_[arbitrary_predicate](*args)
    #
    # Given true, false, or nil, will pass if actual value is true, false or
    # nil (respectively). Given no args means the caller should satisfy an if
    # condition (to be or not to be). 
    #
    # Predicates are any Ruby method that ends in a "?" and returns true or
    # false.  Given be_ followed by arbitrary_predicate (without the "?"),
    # RSpec will match convert that into a query against the target object.
    #
    # The arbitrary_predicate feature will handle any predicate prefixed with
    # "be_an_" (e.g. be_an_instance_of), "be_a_" (e.g. be_a_kind_of) or "be_"
    # (e.g. be_empty), letting you choose the prefix that best suits the
    # predicate.
    def be(*args)
      args.empty? ?
        Matchers::Be.new : equal(*args)
    end

    # passes if target.kind_of?(klass)
    def be_a(klass)
      be_a_kind_of(klass)
    end
    
    alias_method :be_an, :be_a
  end
end
