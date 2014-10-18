class RecalculateBranchesWorker
  include Sidekiq::Worker

  def perform(nik_id)
    CalculateVotesForBranches.calculate(Nik.find(nik_id))
  end
end
