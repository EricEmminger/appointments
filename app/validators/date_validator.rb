class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.present?
    unless value >= Time.now
      record.errors[attribute] << 'is not in the future'
    end
  end
end
