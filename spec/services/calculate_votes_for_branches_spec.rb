require "rails_helper"

describe CalculateVotesForBranches do
  describe "#calculate" do
    let(:root) do
      Nik.create(body: "Some introduction", votes: 1, title: "Some title")
    end

    let!(:child_1) do
      Nik.create(body: "Some paragraph #1", votes: 1, parent_id: root.id)
    end

    let!(:child_2) do
      Nik.create(body: "Some paragraph #2", votes: 2, parent_id: root.id)
    end

    let(:child_3) do
      Nik.create(body: "Some paragraph #3", votes: 2, parent_id: root.id)
    end

    let!(:child_4) do
      Nik.create(body: "Some paragraph #3.1", votes: 1, parent_id: child_3.id)
    end

    it "should calculate votes correctly" do
      described_class.calculate(child_1)
      described_class.calculate(child_2)
      described_class.calculate(child_3)

      expect(BranchWeight.find_by(story_id: root.id, path: child_1.path).weight).to eq(2)
      expect(BranchWeight.find_by(story_id: root.id, path: child_2.path).weight).to eq(3)
      expect(BranchWeight.find_by(story_id: root.id, path: child_4.path).weight).to eq(4)
    end

  end
end
