require "rails_helper"

RSpec.describe "Beelover Hives API", type: :request do
  let!(:beelover) { create(:user, role: "beelover") }
  let!(:beekeeper) { create(:user, role: "beekeeper") }
  let!(:apiary) { create(:apiary, user_id: beekeeper.id) }
  let!(:healthy_hives) { create_list(:hive, 10, apiary_id: apiary.id) }
  let!(:perished_hives) { create_list(:hive, 5, apiary_id: apiary.id, status: "perished") }
  let(:hive_id) { healthy_hives.first.id }
  let(:headers) { authenticated_header(beelover) }

  describe "GET /hives" do
    before { get "/api/v1/beelover/hives", params: {}, headers: headers }

    it "returns hives" do
      expect(json).not_to be_empty
      expect(json["hives"].size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /hives/:id" do
    before { get "/api/v1/beelover/hives/#{hive_id}", params: {}, headers: headers }

    context "when the record exists" do
      it "returns the hive" do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(hive_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:hive_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(json["errors"].first["title"]).to match("Not Found")
      end
    end
  end
end
