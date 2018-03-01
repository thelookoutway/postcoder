require "rails_helper"

RSpec.describe "/", type: :request do
  it "returns unauthorized for requests without the correct api key" do
    get "/"
    expect(response).to be_unauthorized
  end

  it "returns not found for requests where the postcode cannot be found" do
    get "/?api_token=#{ENV["API_TOKEN"]}&postcode=400000"
    expect(response).to be_not_found
  end

  it "returns JSON payload with brackets of postcodes nearby the given postcode" do
    get "/?api_token=#{ENV["API_TOKEN"]}&postcode=4000"
    expect(response).to be_ok
    expect(response.headers["Content-Type"]).to start_with("application/json")
    json = JSON.parse(response.body)
    expect(json.keys).to contain_exactly("3", "7", "10", "20")
    expect(json["3"]).to match_array [4000, 4005, 4006, 4059, 4064, 4101, 4102, 4169]
    expect(json["7"]).to match_array [4000, 4005, 4006, 4007, 4010, 4011, 4030, 4031, 4051, 4053, 4059, 4060, 4064, 4065, 4066, 4067, 4068, 4101, 4102, 4103, 4104, 4105, 4120, 4121, 4151, 4152, 4169, 4170, 4171]
    expect(json["10"]).to match_array [4000, 4005, 4006, 4007, 4009, 4010, 4011, 4012, 4013, 4030, 4031, 4032, 4051, 4053, 4054, 4059, 4060, 4061, 4064, 4065, 4066, 4067, 4068, 4069, 4075, 4101, 4102, 4103, 4104, 4105, 4106, 4107, 4111, 4120, 4121, 4122, 4151, 4152, 4169, 4170, 4171, 4172]
    expect(json["20"]).to match_array [4000, 4005, 4006, 4007, 4008, 4009, 4010, 4011, 4012, 4013, 4014, 4017, 4018, 4030, 4031, 4032, 4034, 4035, 4036, 4037, 4051, 4053, 4054, 4055, 4059, 4060, 4061, 4064, 4065, 4066, 4067, 4068, 4069, 4070, 4073, 4074, 4075, 4076, 4077, 4078, 4101, 4102, 4103, 4104, 4105, 4106, 4107, 4108, 4109, 4110, 4111, 4112, 4113, 4114, 4115, 4116, 4117, 4119, 4120, 4121, 4122, 4123, 4127, 4151, 4152, 4153, 4154, 4156, 4157, 4158, 4159, 4161, 4169, 4170, 4171, 4172, 4173, 4174, 4178, 4179, 4300, 4500, 4520]
  end
end
