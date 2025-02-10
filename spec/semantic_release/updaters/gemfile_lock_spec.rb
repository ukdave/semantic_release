# frozen_string_literal: true

require "tmpdir"

RSpec.describe SemanticRelease::Updaters::GemfileLock do
  describe ".update" do
    before do
      allow(Object).to receive(:`).and_return("")
    end

    context "when a gemspec file is present and the Gemfile.lock is not git-ignored" do
      it "updates and adds the lockfile" do
        described_class.update
        expect(Object).to have_received(:`).with("bundle check && git add Gemfile.lock")
      end
    end

    context "when a gemspec file is present and the Gemfile.lock is git-ignored" do
      before do
        allow(Object).to receive(:system).with("git check-ignore -q Gemfile.lock").and_return(true)
      end

      it "does not update or add the lockfile" do
        described_class.update
        expect(Object).not_to have_received(:`)
      end
    end

    context "when a gemspec file is not present" do
      around do |example|
        Dir.mktmpdir do |dir|
          Dir.chdir(dir) do
            example.run
          end
        end
      end

      it "does not update or add the lockfile" do
        described_class.update
        expect(Object).not_to have_received(:`)
      end
    end
  end
end
