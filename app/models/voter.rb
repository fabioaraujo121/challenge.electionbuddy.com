# frozen_string_literal: true

class Voter < ApplicationRecord
  include Auditable

  belongs_to :election
end
