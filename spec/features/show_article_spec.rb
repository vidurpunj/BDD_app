require 'rails_helper'

RSpec.feature "Showing an article" do
  before do
    @article1 = Article.create(title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256))
    @article2 = Article.create(title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256))
  end

  scenario "A user show an article" do
    visit "/"
    click_link(@article1.title)
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(current_path).to eq(article_path(@article1))
  end
end