# frozen_string_literal: true

#
# Run bin/rails db:seed to populate the DB and have something to see at the very beginning

user = User.create!(email: 'fabio@electionbuddy.com', password: 'Welcome@July')
election = Election.create!(
  user: user,
  name: 'Presidential 2026',
  start_at: Time.current,
  end_at: Time.current + 1.week,
  settings: { visibility: 'public' },
  current_user_id: user.id
)

voter = Voter.create!(
  name: 'Fábio',
  email: 'fabio@electionbuddy.com',
  election: election,
  current_user_id: user.id
)

question = Question.create!(
  name: 'Is that a question?',
  election: election,
  current_user_id: user.id
)

answer = Answer.create!(
  name: 'Yes, it is!',
  question: question,
  current_user_id: user.id
)

##
# Changes
election.update!(current_user_id: user.id, name: 'For president', settings: { visibility: 'private' })
voter.update!(current_user_id: user.id, name: 'Araújo')
question.update!(current_user_id: user.id, name: 'What is this election for?')
answer.update!(current_user_id: user.id, name: 'For president!')
