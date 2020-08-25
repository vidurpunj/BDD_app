require "rails_helper"

RSpec.describe "Articles", type: :request do

  before do
    @article = Article.create(title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256))
  end

  describe 'GET /articles/:id' do
    context 'wih existing article' do
      before { get "/articles/#{@article.id}" }

      it "handle existing article" do
        expect(response.status).to eq(200) # or
        # expect(response).to have_http_status(:ok)
      end
    end

    before { get "/articles/xxxx" }

    it "handle not-existing article" do
      expect(response).to have_http_status(302)
      flash_message = "The article you are looking for could not be found"
      expect(flash[:alert]).to eq(flash_message)
    end
  end
end
