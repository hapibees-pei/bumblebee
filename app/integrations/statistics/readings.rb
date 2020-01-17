module Statistics
  class Readings
    def initialize(params = {})
      new_params = params.slice(:query, :group, :apiary_id, :id)
      @params = sanitizer_params(new_params)
        .permit(:query, :group, :apiary_id, :hive_id).to_h
    end

    def sanitizer_params(params)
      hive = Hive.find(params[:id])
      params[:hive_id] = hive.sensor_id

      params.delete(:id)
      params.delete(:group) if !params[:group]

      validate_params(params)
    end

    def validate_params(params)
      params[:query] = valid_query(params[:query])
      params[:apiary_id] = valid_uuid_format(params[:apiary_id])

      if params[:group]
        params[:group] = valid_group(params[:group])
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

    def valid_group(group)
      group_options = %w(minute hour day)
      if group_options.include?(group)
        group
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
