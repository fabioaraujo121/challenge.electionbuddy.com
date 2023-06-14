# frozen_string_literal: true

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def setup
    @answer = answers(:one)
  end

  def test_includes_auditable_module
    assert_includes Question.included_modules, Auditable
  end

  def test_belongs_to_question
    assert_respond_to @answer, :question
  end

  def test_auditable_on_create
    set_current_user_id
    assert_difference('AuditLog.count') do
      @answer.save
    end
  end

  def test_auditable_on_update
    set_current_user_id
    @answer.save

    assert_difference('AuditLog.count') do
      @answer.update(name: 'Hello World')
    end
  end

  private

  def set_current_user_id
    user = users(:one)
    @answer.current_user_id = user.id
  end
end
