require 'rails_helper'

RSpec.feature "Create Article" do
  scenario "A user create a new article" do
    visit "/"
    click_link 'New Article'
    fill_in :Title, with: Faker::Book.title
    fill_in :Body, with: Faker::Lorem.paragraph_by_chars(number: 256)
    click_button 'Create Article'

    assert page.has_content? "Article was successfully created"
    # expect(:page).to have_content("Article was successfully created")
    expect(page.current_path).to match('/articles/*')
    assert page.current_path.match(/articles\/*/)
  end

  scenario "A user fail to create a new article" do
    visit "/"
    click_link 'New Article'
    fill_in :Title, with: ""
    fill_in :Body, with: ""
    click_button 'Create Article'
    expect(page).to have_content("Article has not be created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end

  scenario "Destroy article" do
    visit "/"
    click_link 'New Article'
    fill_in :Title, with: Faker::Book.title
    fill_in :Body, with: Faker::Lorem.paragraph_by_chars(number: 256)
    click_button 'Create Article'

    visit "/"
    click_link 'Destroy'
    expect(page).to have_content("Article was successfully destroyed.")
  end

end