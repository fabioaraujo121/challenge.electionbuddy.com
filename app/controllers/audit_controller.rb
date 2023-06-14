# frozen_string_literal: true

class AuditController < ApplicationController
  before_action :authenticate_user!
  before_action :set_election

  def index
    @events = @election.events
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_election
    @election = Election.find(params[:election_id])
  end
end
