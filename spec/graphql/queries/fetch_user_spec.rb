require 'rails_helper'

RSpec.describe 'user query' do
  it 'returns the user by id' do
    user_1 = User.create!(name: "Andrew", email: "andrew@turing.edu")
    user_2 = User.create!(name: "Carl", email: "carl@turing.edu")
    
    query = <<~GQL
    query {
      fetchUser(id: #{user_1.id}) {
        name
        email
        activities {
          name
        }
      }
    }
    GQL
    result = SwolifyBeSchema.execute(query)

    expect(result.dig("data", "fetchUser", "name")).to eq("Andrew")
  end
end