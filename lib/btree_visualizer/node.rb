# frozen_string_literal: true

module BtreeVisualizer
  class Node
    attr_accessor :t, :keys, :children, :leaf

    def initialize(t, leaf = true)
      @t = t # minimum degree
      @leaf = leaf # is leaf?
      @keys = []
      @children = []
    end

    def self.copy_by(src)
      Node.new(src.t, src.leaf).tap do |node|
        node.keys = src.keys.dup
        node.children = src.children.dup
      end
    end

    def insert_non_full(key)
      i = @keys.size - 1

      i -= 1 while i >= 0 && @keys[i] > key
      if @leaf
        @keys.insert(i + 1, key)
      else
        i += 1
        if @children[i].keys.size == (2 * @t) - 1
          split_child(i, @children[i])
          i += 1 if !i.zero? && @keys[i] < key
        end
        @children[i].insert_non_full(key)
      end
    end

    def split_child(i, y)
      z = Node.new(@t, y.leaf)
      z.keys = y.keys[@t..]
      parent_key = y.keys - (z.keys + y.keys[0...@t - 1])
      y.keys = y.keys[0...@t - 1]

      unless y.leaf
        z.children = y.children[@t..]
        y.children = y.children[0...@t]
      end

      @children.insert(i + 1, z)
      @keys.insert(i, parent_key.first)
    end
  end
end
