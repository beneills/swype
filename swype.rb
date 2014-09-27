#!/usr/bin/env ruby

require 'yaml'

if ARGV.length != 2
  puts "usage: swype.rb grid.yaml word"
  exit 1
end

$grid = {}

def parse_grid_yaml(filename)
  Hash[YAML.load_file(filename).map do |key, coords|
         [key, [coords['x'], coords['y']]]
       end]
end

# https://blog.philipcunningham.org/posts/ruby-euclidean-distance
def euclidean_distance(p1, p2)
  Math.sqrt(p1.zip(p2).map{|a,b| a-b}.map{|d| d*d}.reduce(:+))
end

def path_length_jagged(word)
  word.chars.each_cons(2).map do |tuple|
    euclidean_distance($grid[tuple[0]], $grid[tuple[1]])
  end.reduce(:+)
end

def main
  grid = ARGV[0]
  word = ARGV[1]
  
  $grid = parse_grid_yaml(grid)

  puts path_length_jagged(word).round
end

main
