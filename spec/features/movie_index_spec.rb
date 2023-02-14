require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  before do
    @user1 = User.create(name: 'User One', email: 'user1@test.com', password: 'password123')
    i = 1
    20.times do
      Movie.create(title: "Movie #{i} Title", rating: rand(1..10),
                   description: "This is a description about Movie #{i}")
      i += 1
    end
  end

  it 'shows all movies' do
    # session[:user_id] = @user1.id
    # get(:show, nil, {'user_id' => @user1.id})
    # get :show, nil, {user_id: @user1.id}
    # process :get, '/dashboard', session: {user_id: @user1.id}
    # IntegrationTest#open_session
    # require 'pry'; binding.pry
    # get(:show, session: {'user_id' 
    # 
    # => @user1.id})


    visit login_path
    fill_in 'email', with: @user1.email
    fill_in 'password', with: @user1.password
    click_button 'Log In'

    # save_and_open_page
    visit '/dashboard'

    click_button 'Find Top Rated Movies'

    expect(current_path).to eq("/movies")

    expect(page).to have_content('Top Rated Movies')
    Movie.all.each do |movie|
      within("#movie-#{movie.id}") do
        expect(page).to have_link(movie.title)
        expect(page).to have_content("Rating: #{movie.rating}/10")
      end
    end
  end
end
