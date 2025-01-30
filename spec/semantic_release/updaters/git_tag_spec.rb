# frozen_string_literal: true

RSpec.describe SemanticRelease::Updaters::GitTag do
  describe ".update" do
    let(:semver) { instance_double(SemanticRelease::Semver, :semver, to_s: "1.2.3") }

    before do
      allow(SemanticRelease::Semver).to receive(:load).and_return(semver)
      allow(Object).to receive(:`).and_return("")
    end

    it "commits the .semver file and tags it with the current version" do
      described_class.update
      expect(Object).to have_received(:`).with(
        "git add .semver && git commit -m 'Increment version to v1.2.3' && git tag v1.2.3 -a -m '#{Time.now}'"
      )
    end
  end
end
