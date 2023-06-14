# frozen_string_literal: true

module Auditable
  extend ActiveSupport::Concern

  included do
    attr_accessor :current_user_id

    has_many :audit_logs, as: :auditable

    before_update :create_audit_log
    after_create  :create_audit_log
  end

  def create_audit_log
    return if current_user_id.nil?

    audit_log_temp = AuditLog.new(
      auditable_type: self.class.name,
      auditable_id: id,
      owner_type: 'User',
      owner_id: current_user_id
    )

    audit_log_temp.value = mapped_values

    audit_log_temp.save
    true
  end

  def mapped_values
    log_value = {
      after_record: attributes,
      before_record: nil,
      difference: {}
    }

    log_value = map_changes(log_value) if changes.length.positive?

    log_value
  end

  private

  def map_changes(log_value)
    before_record = dup

    changes.each do |field, values|
      next if field == 'updated_at'

      log_value = map_differences(log_value, field, values)

      before_record.send("#{field}=", values[0])
    end

    log_value[:before_record] = before_record.attributes

    log_value
  end

  def map_differences(log_value, field, values)
    log_value[:difference][field.to_sym] ||= {}
    log_value[:difference][field.to_sym][:before] = values[0]
    log_value[:difference][field.to_sym][:after]  = values[1]
    log_value
  end
end
