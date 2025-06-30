# frozen_string_literal: true

module WordSegmentation
  # A class to determine if a string can be segmented into words from a given dictionary
  class Solver
    def self.can_segment?(string, dictionary)
      new(string, dictionary).can_segment?
    end

    def initialize(string, dictionary)
      @string = string.to_s
      @dictionary = Set.new(dictionary.map(&:to_s))
      @memo = {}
    end

    def can_segment?
      return true if @string.empty?

      segment_from_position(0)
    end

    private

    def segment_from_position(start_pos)
      return true if start_pos >= @string.length
      return @memo[start_pos] if @memo.key?(start_pos)

      @memo[start_pos] = find_valid_segmentation(start_pos)
    end

    def find_valid_segmentation(start_pos)
      (start_pos...@string.length).any? do |end_pos|
        word = @string[start_pos..end_pos]
        @dictionary.include?(word) && segment_from_position(end_pos + 1)
      end
    end
  end
end
