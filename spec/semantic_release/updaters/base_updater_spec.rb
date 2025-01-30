# frozen_string_literal: true

RSpec.describe SemanticRelease::Updaters::BaseUpdater do
  describe ".update" do
    it "raises a 'not implemented' error" do
      expect { described_class.update }.to raise_error "Not implemented"
    end
  end

  describe ".current_version" do
    let(:semver) { instance_double(SemanticRelease::Semver, :semver, to_s: "1.2.3") }

    before do
      allow(SemanticRelease::Semver).to receive(:load).and_return(semver)
    end

    it "loads the .semver file" do
      described_class.current_version
      expect(SemanticRelease::Semver).to have_received(:load).with(".semver")
    end

    it "returns the current version" do
      expect(described_class.current_version).to eq "1.2.3"
    end
  end
end
