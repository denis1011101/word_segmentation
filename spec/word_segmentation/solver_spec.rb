# frozen_string_literal: true

RSpec.describe WordSegmentation::Solver do
  describe ".can_segment?" do
    context "when string can be segmented" do
      it "returns true for the given example" do
        string = "двесотни"
        dictionary = ["две", "сотни", "тысячи"]

        expect(described_class.can_segment?(string, dictionary)).to be true
      end

      it "returns true for single word in dictionary" do
        string = "hello"
        dictionary = ["hello", "world"]

        expect(described_class.can_segment?(string, dictionary)).to be true
      end

      it "returns true for multiple word segmentation" do
        string = "helloworld"
        dictionary = ["hello", "world"]

        expect(described_class.can_segment?(string, dictionary)).to be true
      end

      it "returns true for complex segmentation" do
        string = "catsanddog"
        dictionary = ["cat", "cats", "and", "sand", "dog"]

        expect(described_class.can_segment?(string, dictionary)).to be true
      end

      it "returns true for empty string" do
        string = ""
        dictionary = ["hello", "world"]

        expect(described_class.can_segment?(string, dictionary)).to be true
      end
    end

    context "when string cannot be segmented" do
      it "returns false when no valid segmentation exists" do
        string = "catsandog"
        dictionary = ["cats", "dog", "sand", "and", "cat"]

        expect(described_class.can_segment?(string, dictionary)).to be false
      end

      it "returns false when dictionary is empty" do
        string = "hello"
        dictionary = []

        expect(described_class.can_segment?(string, dictionary)).to be false
      end

      it "returns false when no words match" do
        string = "test"
        dictionary = ["hello", "world"]

        expect(described_class.can_segment?(string, dictionary)).to be false
      end
    end

    context "with edge cases" do
      it "handles nil string gracefully" do
        string = nil
        dictionary = ["hello", "world"]

        expect(described_class.can_segment?(string, dictionary)).to be true
      end

      it "handles duplicate words in dictionary" do
        string = "hellohello"
        dictionary = ["hello", "hello", "world"]

        expect(described_class.can_segment?(string, dictionary)).to be true
      end

      it "handles case sensitivity" do
        string = "Hello"
        dictionary = ["hello", "world"]

        expect(described_class.can_segment?(string, dictionary)).to be false
      end
    end

    context "performance tests" do
      it "handles long strings efficiently" do
        string = "a" * 100
        dictionary = ["a", "aa", "aaa"]

        start_time = Time.now
        described_class.can_segment?(string, dictionary)
        elapsed = Time.now - start_time

        expect(elapsed).to be < 1
      end
    end
  end

  describe "#initialize" do
    it "converts dictionary items to strings" do
      solver = described_class.new("test", [123, :symbol, "string"])
      expect(solver.can_segment?).to be false
    end
  end
end
