# frozen_string_literal: true
require "pry"
require "pry-nav"
module RuboCop
  module Cop
    module Minitest
      include MinitestExplorationHelpers
      # This cop checks if test cases contain too many assertion calls.
      # The maximum allowed assertion calls is configurable.
      #
      # @example Max: 1
      #   # bad
      #   class FooTest < Minitest::Test
      #     def test_asserts_twice
      #       assert_equal(42, do_something)
      #       assert_empty(array)
      #     end
      #   end
      #
      #   # good
      #   class FooTest < Minitest::Test
      #     def test_asserts_once
      #       assert_equal(42, do_something)
      #     end
      #
      #     def test_another_asserts_once
      #       assert_empty(array)
      #     end
      #   end
      #
      class DuplicatedTest < Base
        include ConfigurableMax
        include MinitestExplorationHelpers

        MSG = 'Subclasses causes the parent test to run twice.'

        def on_class(class_node)
          binding.pry
          return
          # return unless the parent class is minitest
          return unless test_class?(class_node)

          # return unless the class has tests methods
          return unless has_test_methods?(class_node)

          return unless has_children_test_classes?

          message = format(MSG)
          add_offense(node, message: message)
        end

        private

        def has_children_test_classes?(class_node)
          # TODO: FIX ME I DON'T KNOW HOW TO TEST THAT IS ANY CHILDREN WICH IMPLEMENTS A TEST
        
          class_node.each_descendant do |node|
            return unless node.
            puts n 
            puts "-"
          end
        end
      end
    end
  end
end
