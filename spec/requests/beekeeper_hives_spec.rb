require "rails_helper"

RSpec.describe "Beekeeper Hives API", type: :request do
  let!(:user) { create(:user) }
  let!(:apiary) { create(:apiary, user_id: user.id) }
  let(:apiary_id) { apiary.id }
  let!(:hives) { create_list(:hive, 10, apiary_id: apiary.id) }
  let(:hive_id) { hives.first.id }
  let(:headers) { authenticated_header(user) }

  before { user.add_role(:beekeeper) }

  describe "GET /hives" do
    before { get "/api/v1/beekeeper/apiaries/#{apiary_id}/hives", params: {}, headers: headers }

    it "returns hives" do
      expect(json).not_to be_empty
      expect(json["hives"].size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /hives/:id" do
    before { get "/api/v1/beekeeper/apiaries/#{apiary_id}/hives/#{hive_id}", params: {}, headers: headers }

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

  describe "POST /hives" do
    let(:valid_attributes) do
      {
        hive: {
          name: "BeeMaker",
          description: "Lots os bees",
          bee_number: 100,
          sensor_id: 50,
          status: :healthy,
          success_rate: 5
        }
      }.to_json
    end

    context "when the request is valid" do
      before { post "/api/v1/beekeeper/apiaries/#{apiary_id}/hives", params: valid_attributes, headers: headers }

      it "creates a hive" do
        expect(json["name"]).to eq("BeeMaker")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post "/api/v1/beekeeper/apiaries/#{apiary_id}/hives", params: { title: "Foobar" }.to_json, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(json["errors"].first["title"])
          .to match("Unprocessable Entity")
      end
    end
  end

  describe "PUT /hives/:id" do
    let(:valid_attributes) do
      {
        hive: {
          name: "BeeMaker",
          description: "Lots os bees",
          bee_number: 100,
          sensor_id: 50,
          status: :healthy,
          success_rate: 5
        }
      }.to_json
    end

    context "when the record exists" do
      before { put "/api/v1/beekeeper/apiaries/#{apiary_id}/hives/#{hive_id}", params: valid_attributes, headers: headers }

      it "updates the record" do
        expect(response.body).not_to be_empty
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE /hives/:id" do
    before { delete "/api/v1/beekeeper/apiaries/#{apiary_id}/hives/#{hive_id}", params: {}, headers: headers }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end
end
