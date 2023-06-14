# frozen_string_literal: true

class CreateAuditLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :audit_logs do |t|
      t.references :auditable, polymorphic: true, null: false
      t.references :owner, polymorphic: true, null: false
      t.json :value

      t.timestamps
    end
  end
end
