require 'rails_helper'

RSpec.describe 'all users query' do
  let!(:susan) { User.create!(name: "Susan", email: "susan@turing.edu") }
  let!(:james) { User.create!(name: "James", email: "james@turing.edu") }
  let!(:andrew) { User.create!(name: "Andrew", email: "andrew@turing.edu") }

  it 'returns all users' do
    query = <<~GQL
    query {
      fetchAllUsers{
        id
        name
        email
      }
    }
    GQL
    result = SwolifyBeSchema.execute(query)
    require "pry"; binding.pry
  end
end
