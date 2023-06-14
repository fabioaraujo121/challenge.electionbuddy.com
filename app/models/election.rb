# frozen_string_literal: true

class Election < ApplicationRecord
  include Auditable

  has_many :questions
  belongs_to :user

  serialize :settings, Hash

  def visibility
    settings[:visibility]
  end

  def visibility=(value)
    settings[:visibility] = value
  end

  def events
    question_ids = questions.pluck(:id)
    voter_ids = Voter.where(election_id: id).pluck(:id)
    answer_ids = Answer.where(question_id: question_ids).pluck(:id)

    audit_log_query(question_ids, answer_ids, voter_ids)
  end

  private

  def audit_log_query(question_ids, answer_ids, voter_ids)
    AuditLog.where(owner: user)
            .where(
              "(auditable_type = 'Question' AND auditable_id IN (?)) OR " \
              "(auditable_type = 'Answer' AND auditable_id IN (?)) OR " \
              "(auditable_type = 'Voter' AND auditable_id IN (?)) OR " \
              "(auditable_type = 'Election' AND auditable_id = ?)",
              question_ids, answer_ids, voter_ids, id
            )
            .order(created_at: :desc)
  end
end
