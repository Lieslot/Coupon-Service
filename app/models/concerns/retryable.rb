
module Retryable
  def retry_on_lock_error(max_retries = 3)
    retries = 0
    begin
      yield
    rescue ActiveRecord::StatementInvalid => e
      if retries < max_retries
        retries += 1
        Rails.logger.warn("Database lock encountered, retrying... (#{retries}/#{max_retries})")
        sleep(1)
        retry
      else
        raise e
      end
    end
  end
end