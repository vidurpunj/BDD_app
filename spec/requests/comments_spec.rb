require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before do
    password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
    @john = User.create({email: Faker::Internet.email, password: password})
    @john.confirm
    password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
    @fred = User.create({email: Faker::Internet.email, password: password})
    @fred.confirm
    @article = Article.create({title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256), user: @john})
  end

  describe 'POST /articles/:id/comments' do
    context "with non signed-in user" do
      before do
        post "/articles/#{@article.id}/comments", params: { comment: {body: Faker::Lorem.paragraph_by_chars(number: 256)}}
      end
      it "redirect user to sign up page" do
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq(flash_message)
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "with a loggedin user" do
      before do
        login_as(@fred)
        post "/articles/#{@article.id}/comments", params: { comment: {body: Faker::Lorem.paragraph_by_chars(number: 256)}}
      end

      it "create the comment successfully" do
        flash_message = 'Comment has been created.'
        expect(flash[:notice]).to eq(flash_message)
        expect(response).to redirect_to article_path(@article)
        expect(response).to have_http_status 302
      end
    end
  end

end