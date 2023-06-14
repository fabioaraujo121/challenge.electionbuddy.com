# frozen_string_literal: true

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def setup
    @question = questions(:one)
  end

  def test_includes_auditable_module
    assert_includes Question.included_modules, Auditable
  end

  def test_belongs_to_election
    assert_respond_to @question, :election
  end

  def test_auditable_on_create
    set_current_user_id
    assert_difference('AuditLog.count') do
      @question.save
    end
  end

  def test_auditable_on_update
    set_current_user_id
    @question.save

    assert_difference('AuditLog.count') do
      @question.update(name: 'Hello World')
    end
  end

  private

  def set_current_user_id
    user = users(:one)
    @question.current_user_id = user.id
  end
end
