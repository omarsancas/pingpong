class  ScoreValidator < ActiveModel::Validator
  HIGH_SCORE = 21
  DIFF_SCORE = 2

  def validate(record)
    scores = options[:fields].map { |field| record.send(field).try(:to_i) }

    return if scores.include?(nil)

    if scores.max < HIGH_SCORE
      record.errors[:score] << "can't be less than #{HIGH_SCORE}"
    elsif scores.reduce(:-).abs < DIFF_SCORE
      record.errors[:score] << <<-TXT.squish
        should have a score difference greater or equal than #{DIFF_SCORE}
      TXT
    elsif scores.min <= (HIGH_SCORE - DIFF_SCORE) && HIGH_SCORE < scores.max
      record.errors[:score] << "is invalid"
    end
  end
end
