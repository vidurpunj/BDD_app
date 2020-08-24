require 'rails_helper'

RSpec.feature do
  before do
    @article1 = Article.create(title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256))
    @article2 = Article.create(title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256))
  end

  scenario "A user list all the articles" do
    visit('/')

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)

    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end
end
