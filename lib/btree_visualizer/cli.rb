# frozen_string_literal: true

module BtreeVisualizer
  class CLI
    def run
      instance = Btree.new(3)

      loop do
        print '> '
        input = gets.chomp
        break if input == 'exit'

        case input
        when 'help'
          puts 'Commands: help, exit, insert, print'
        when 'insert'
          print 'Enter a value to insert: '
          value = gets.chomp.to_i
          instance.insert(value)
        when 'print'
          instance.print
        else
          puts 'Unknown command. Type help to see a list of commands.'
        end
      end
    end
  end
end
