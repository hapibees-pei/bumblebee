class IotApiaryJob < ApplicationJob
  queue_as :default

  def perform(apiary_id)
    apiary = Apiary.find(apiary_id)
    if apiary
      apiary.status = false
      onboarding = {
        onboarding: {
          uuid: apiary.id,
          ip: apiary.ip,
          port: apiary.port
        }
      }
      HTTParty.post(
        Rails.application.credentials.iot_url + "/api/v1/onboarding",
        body: onboarding
      )
    end
  end
end
