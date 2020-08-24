require 'rails_helper'

RSpec.feature "Create Aricle" do
  scenario "A user create a new article" do
    visit "/"
    click_link 'New Article'
    fill_in :Title, with: Faker::Book.title
    fill_in :Body, with: Faker::Lorem.paragraph_by_chars(number: 256)
    click_button 'Create Article'

    assert page.has_content? "Article was successfully created"
    # expect(:page).to have_content("Article was successfully created")
    # expect(page.current_path).to eq('/articles/*')
    assert page.current_path.match(/articles\/*/)
  end
end