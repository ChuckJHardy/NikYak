class CalculateVotesForBranches
  class << self
    def calculate(node)
      new(node).calculate
    end
  end

  def initialize(node)
    @node = node
  end

  def calculate
    last_leaves.each do |leave|
      ActiveRecord::Base.transaction do
        sum = leave.self_and_ancestors.sum(:votes)
        bw = BranchWeight.where(
          story_id: leave.root.id, path: leave.path
        ).first_or_initialize(weight: sum)
        bw.save
      end
    end
  end

  private

  def last_leaves
    if @node.children.any?
      @node.last_leaves
    else
      [ @node ]
    end
  end
end
