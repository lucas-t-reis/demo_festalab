class PhoneValidator < ActiveModel::EachValidator
    # Source https://pt.stackoverflow.com/a/46676
    VALID_PHONE = /^\(?[1-9]{2}\)? ?(?:[2-8]|9[0-9])[0-9]{3}\-?[0-9]{4}\z/

    def validate_each(record, attribute, value)
      unless value =~ VALID_PHONE
        record.errors.add(attribute, options[:message] || "is not a valid phone")
      end
    end
end