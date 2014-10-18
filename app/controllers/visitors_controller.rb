class VisitorsController < ApplicationController
  def index
    @niks = Nik.all
  end
end
