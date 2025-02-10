# frozen_string_literal: true

require "tmpdir"

RSpec.describe SemanticRelease::Updaters::GitTag do
  describe ".update" do
    let(:semver) { instance_double(SemanticRelease::Semver, :semver, to_s: "1.2.3") }

    before do
      allow(SemanticRelease::Semver).to receive(:load).and_return(semver)
      allow(Object).to receive(:`).and_return("")
      allow(Object).to receive(:`).and_return("main\n")
    end

    it "commits the .semver file and tags it with the current version" do
      described_class.update
      expect(Object).to have_received(:`).with(
        "git add .semver && git commit -m 'Increment version to v1.2.3' && git tag v1.2.3 -a -m '#{Time.now}'"
      )
    end

    it "displays a message about pushing the tag" do
      expect { described_class.update }.to output(
        /To push the new tag, use 'git push origin main --tags'/
      ).to_stdout
    end

    context "when a gemspec file is present" do
      it "displays a message about building and pushing the .gem file" do
        expect { described_class.update }.to output(
          /To build and push the .gem file to rubygems.org use, 'bundle exec rake release'/
        ).to_stdout
      end

      it "does not display the message when disabled" do
        allow(SemanticRelease.configuration).to receive(:disable_rubygems_message).and_return(true)
        expect { described_class.update }.not_to output(/rubygems/).to_stdout
      end
    end

    context "when a gemspec file is not present" do
      it "does not display a message about building and pushing the .gem file" do
        Dir.mktmpdir do |dir|
          Dir.chdir(dir) do
            expect { described_class.update }.not_to output(/rubygems/).to_stdout
          end
        end
      end
    end
  end
end
