# frozen_string_literal: true

require "json"

module SemanticRelease
  class Semver
    include Comparable

    attr_reader :major, :minor, :patch

    def initialize(major: 0, minor: 0, patch: 0, file: nil)
      @major = major
      @minor = minor
      @patch = patch
      @file = file
    end

    def self.load(file)
      data = JSON.parse(File.read(file))
      new(major: data["major"], minor: data["minor"], patch: data["patch"], file: file)
    end

    def save(file = nil)
      f = file || @file
      File.write(f, JSON.generate(to_h))
    end

    def increment(term)
      case term.to_sym
      when :major then increment_major
      when :minor then increment_minor
      when :patch then increment_patch
      else raise ArgumentError, "Bad term"
      end
      self
    end

    def increment_major
      @major += 1
      @minor = 0
      @patch = 0
    end

    def increment_minor
      @minor += 1
      @patch = 0
    end

    def increment_patch
      @patch += 1
    end

    def to_s
      [@major, @minor, @patch].join(".")
    end

    def to_h
      { major: @major, minor: @minor, patch: @patch }
    end

    def <=>(other)
      %i[major minor patch].each do |method|
        comparison = (send(method) <=> other.send(method))
        return comparison unless comparison.zero?
      end
      0
    end
  end
end
