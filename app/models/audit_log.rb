# frozen_string_literal: true

class AuditLog < ApplicationRecord
  belongs_to :auditable, polymorphic: true
  belongs_to :owner, polymorphic: true

  serialize :value, Hash
end
