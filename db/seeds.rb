require 'poll'

Poll.create(id: 1,
            name: 'What is your favorite weekend activity?',
            choice_one: 'Netflix',
            choice_two: 'Gaming',
            choice_three: 'Dining',
            choice_four: 'NightClub')
Answer.create(id: 1, poll_id: 1, item: 'Netflix', count: 0)
Answer.create(id: 2, poll_id: 1, item: 'Gaming', count: 0)
Answer.create(id: 3, poll_id: 1, item: 'Dining', count: 0)
Answer.create(id: 4, poll_id: 1, item: 'NightClub', count: 0)
