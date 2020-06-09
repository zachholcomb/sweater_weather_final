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
      create_error(message)
    end

    def mismatched_passwords
      message = 'Password and pasword confirmation dont match'
      create_error(message)
    end

    def same_email
      message = 'Email already exists'
      create_error(message)
    end

    def no_user
      message = "Can't find user with that email"
      create_error(message)
    end
    
    def password
      message = "Bad credentials"
      create_error(message)
    end

    def unauthorized
      message = "Unauthorized"
      create_error(message)
    end

    def create_error(message)
      error = Error.new(message)
      ErrorSerializer.new(error)
    end
  end
end