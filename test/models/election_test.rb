# frozen_string_literal: true

require 'test_helper'

class ElectionTest < ActiveSupport::TestCase
  def setup
    @election = elections(:one)
  end

  def test_includes_auditable_module
    assert_includes Election.included_modules, Auditable
  end

  def test_auditable_on_create
    set_current_user_id
    assert_difference('AuditLog.count') do
      @election.save
    end
  end

  def test_auditable_on_update
    set_current_user_id
    @election.save

    assert_difference('AuditLog.count') do
      @election.update(name: 'Hello World')
    end
  end

  private

  def set_current_user_id
    user = users(:one)
    @election.current_user_id = user.id
  end
end
