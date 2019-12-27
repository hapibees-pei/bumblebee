module Statistics
  class Readings
    def initialize(params = {})
      new_params = params.slice(:query, :time_unity, :apiary_id, :id)
      @params = sanitizer_params(new_params)
        .permit(:query, :time_unity, :apiary_id, :hive_id).to_h
    end

    def sanitizer_params(params)
      hive = Hive.find(params[:id])
      params[:hive_id] = hive.sensor_id

      params.delete(:id)
      params.delete(:time_unity) if !params[:time_unity]

      validate_params(params)
    end

    def validate_params(params)
      params[:query] = valid_query(params[:query])
      params[:apiary_id] = valid_uuid_format(params[:apiary_id])

      if params[:time_unity]
        params[:time_unity] = valid_time_unity(params[:time_unity])
      end

      params
    end

    def valid_uuid_format(uuid)
      uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
      if uuid_regex.match?(uuid.to_s.downcase)
        uuid
      else
        raise ActiveRecord::RecordInvalid
      end
    end

    def valid_query(sensor_type)
      sensor_type_options = %w(light temperature pressure accelerometer noise humidity)
      if sensor_type_options.include?(sensor_type)
        sensor_type
      else
        raise ActiveRecord::RecordInvalid
      end
    end

    def valid_time_unity(time_unity)
      time_unity_options = %w(minute hour day)
      if time_unity_options.include?(time_unity)
        time_unity
      else
        raise ActiveRecord::RecordInvalid
      end
    end

    def call
      base_url = "/api/v1/readings?"
      query = base_url + @params.map { |k, v| "#{k}=#{v}" }.join("&")

      HTTParty.get(Rails.application.credentials.iot_url + query)
    end
  end
end
