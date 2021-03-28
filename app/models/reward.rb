class Reward < ApplicationRecord
  belongs_to :user

  attr_accessor :initial_choice
  attr_accessor :reward_choice
end
