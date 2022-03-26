# frozen_string_literal: true
require "pry"
require "pry-nav"
module RuboCop
  module Cop
    module Minitest
      include MinitestExplorationHelpers
      # This cop checks if test cases contain duplicate tests.
      # If a class with tests has a child with tests, then the first will run its tests twice.
      #
      # @example
      #   # bad
      #   class BarTest < Minitest::Test
      #     def test_bar # it will run this test twice.
      #     end
      #   end
      #   class FooTest < BarTest
      #     def test_foo
      #     end
      #   end
      #
      #
      #   # good
      #   class BarTest < Minitest::Test
      #     def test_bar
      #     end
      #   end
      #   class FooTest < Minitest::Test
      #     def test_foo
      #     end
      #   end
      #
      #  or 
      #
      #   class BarTest < Minitest::Test
      #   end
      #   class FooTest
      #     def test_foo
      #     end
      #
      #     def test_bar
      #     end
      #   end
      #
      class DuplicatedTest < Base
        include ConfigurableMax
        include MinitestExplorationHelpers

        MSG = 'Subclasses causes the parent test to run twice.'

        def on_def(node)
          binding.pry
        end

        def on_send(node)
          binding.pry
        end

        def on_class(class_node)
          # return unless the class is a test class.
          return unless test_class?(class_node)

          # return unless the class has tests methods.
          return unless has_test_methods?(class_node)

          # return unless there is a child test class with tests on it.
          return unless has_children_test_classes?(class_node)
          binding.pry
          return
          message = format(MSG)
          add_offense(class_node, message: message)
        end

        private

        # class_node.each_descendant(:sclass) do |node|
        #   puts "foo"
        # end
        # nil

        def has_children_test_classes?(class_node)
          class_node.each_descendant(:send) do |node|
            binding.pry
            return unless node
            puts node 
            puts "-"
          end
        end

        def has_test_methods?(class_node)
          test_cases(class_node).size > 0
        end
      end
    end
  end
end
