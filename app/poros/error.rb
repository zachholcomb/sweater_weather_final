class Error
  attr_reader :id,
              :message
  
  def initialize(message)
    @id = nil
    @message = message
  end
  
  class << self
    def missing_params
      message = 'Missing required fields'
      error = Error.new(message)
      ErrorSerializer.new(error)
    end

    def mismatched_passwords
      message = 'Password and pasword confirmation dont match'
      error = Error.new(message)
      ErrorSerializer.new(error)
    end

    def same_email
      message = 'Email already exists'
      error = Error.new(message)
      ErrorSerializer.new(error)
    end
  end
end