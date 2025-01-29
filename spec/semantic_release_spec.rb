# frozen_string_literal: true

RSpec.describe SemanticRelease do
  it "has a version number" do
    expect(SemanticRelease::VERSION).not_to be_nil
  end
end
