class ApplicationController < ActionController::API
  def log_request(status, errors = nil)
    ApiRequest.create(
      endpoint: request.fullpath,
      remote_ip: request.remote_ip,
      status: status,
      payload: params,
      request_errors: errors.to_json,
      created_at: Time.now
    )
  end
end
