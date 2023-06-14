# frozen_string_literal: true

module AuditHelper
  def event_action(log)
    return 'Created' if log.value[:difference].blank?

    'Updated'
  end

  def show_attributes(log, record_at = 'before_record')
    return if log.value[:difference].blank?

    obj = instantiate_auditable(log, record_at)
    generate_attribute_tags(log, obj)
  end

  private

  def instantiate_auditable(log, record_at)
    auditable_class = log.auditable_type.constantize
    auditable_class.new(log.value[record_at.to_sym])
  end

  def generate_attribute_tags(log, obj)
    log.value[:difference].keys.map do |key|
      content_tag(:p, "#{key}: #{obj.send(key)}")
    end.join.html_safe
  end
end
