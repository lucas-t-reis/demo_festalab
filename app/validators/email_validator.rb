class EmailValidator < ActiveModel::EachValidator
    # Source: https://stackoverflow.com/a/5488868d
    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    def validate_each(record, attribute, value)
      unless value =~ VALID_EMAIL_REGEX
        record.errors.add(attribute, options[:message] || "is not a valid email")
      end
    end
end
