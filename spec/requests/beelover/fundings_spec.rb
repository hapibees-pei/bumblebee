require "rails_helper"

RSpec.describe "Beelover Fundings API", type: :request do
  let!(:beelover) { create(:user, role: "beelover") }
  let!(:apiary) { create(:apiary, user_id: beelover.id) }
  let!(:hive) { create(:hive, apiary_id: apiary.id) }
  let!(:fundings_list) { create_list(:funding, 15, user_id: beelover.id, hive_id: hive.id) }
  let(:headers) { authenticated_header(beelover) }

  describe "GET /fundings" do
    before { get "/api/v1/beelover/fundings", params: {}, headers: headers }

    it "returns fundings" do
      expect(json).not_to be_empty
      expect(json["fundings"].size).to eq(15)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /fundings" do
    let(:valid_attributes) do
      {
        funding: {
          hive_id: hive.id,
          price_cents: 111
        }
      }.to_json
    end

    context "when the request is valid" do
      before { post "/api/v1/beelover/fundings", params: valid_attributes, headers: headers }

      it "creates a funding" do
        expect(json["hive_id"]).to eq(hive.id)
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post "/api/v1/beelover/fundings", params: { title: "Foobar" }.to_json, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(json["errors"].first["title"])
          .to match("Unprocessable Entity")
      end
    end
  end
end
