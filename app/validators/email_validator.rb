class EmailValidator < ActiveModel::EachValidator
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  
  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || 'is not a valid email') unless VALID_EMAIL_REGEX =~ value
  end
end