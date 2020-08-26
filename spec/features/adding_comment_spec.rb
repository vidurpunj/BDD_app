require 'rails_helper'

RSpec.feature 'Adding reviews to Article' do
  before do
    password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
    @john = User.create({email: Faker::Internet.email, password: password})
    @john.confirm
    password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
    @fred = User.create({email: Faker::Internet.email, password: password})
    @fred.confirm
    @article = Article.create({title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256), user: @john})
  end

  scenario 'permit a signed-in user to write a review' do
    login_as(@fred)
    visit('/')
    click_link @article.title
    review = Faker::Lorem.paragraph_by_chars(number: 256)
    fill_in "comment_body", with: review
    click_button 'New Comment'
    expect(page).to have_content('Comment has been created.')
    expect(page).to have_content(review)
    expect(current_path).to eq(article_path(@article))
  end
end