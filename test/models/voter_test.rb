# frozen_string_literal: true

require 'test_helper'

class VoterTest < ActiveSupport::TestCase
  def setup
    @voter = voters(:one)
  end

  def test_includes_auditable_module
    assert_includes Voter.included_modules, Auditable
  end

  def test_belongs_to_election
    assert_respond_to @voter, :election
  end

  def test_auditable_on_create
    set_current_user_id
    assert_difference('AuditLog.count') do
      @voter.save
    end
  end

  def test_auditable_on_update
    set_current_user_id
    @voter.save

    assert_difference('AuditLog.count') do
      @voter.update(name: 'Hello World')
    end
  end

  private

  def set_current_user_id
    user = users(:one)
    @voter.current_user_id = user.id
  end
end
