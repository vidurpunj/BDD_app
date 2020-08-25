require 'rails_helper'

RSpec.feature "Deleting an Article" do
  before do
    @article = Article.create(title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256))
  end

  scenario "Delete Article"do
    visit '/'
    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article was successfully destroyed.")
    expect(current_path).to eq(articles_path)
  end
end