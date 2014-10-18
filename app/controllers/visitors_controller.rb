class VisitorsController < ApplicationController
  def index
    @niks = Nik.roots
  end
end
