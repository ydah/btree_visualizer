# frozen_string_literal: true

module BtreeVisualizer
  class Btree
    def initialize(t)
      @t = t
      @root = Node.new(t)
    end

    def insert(key)
      if @root.keys.size == (2 * @t) - 1
        tmp_root = Node.copy_by(@root)
        s = Node.new(@t, false)
        s.children << tmp_root
        s.split_child(0, tmp_root)
        @root = s
        s.insert_non_full(key)
      else
        @root.insert_non_full(key)
      end
    end

    def print(node = @root, indent = 0, branch = '')
      node_str = node.keys.join(', ')
      puts "#{' ' * indent}#{branch}#{node_str}"

      return if node.leaf

      node.children.each_with_index do |child, index|
        new_branch = index == node.children.size - 1 ? '└── ' : '├── '
        print(child, indent + 2, new_branch)
      end
    end
  end
end
