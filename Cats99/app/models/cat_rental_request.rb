class CatRentalRequest < ActiveRecord::Base
  STATUS = %w(PENDING APPROVED DENIED)
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, presence: true,
    inclusion: { in: STATUS, message: "Invalid Status." }
  validate :no_overlaps

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat

  def over_lapping_approved_requests
    @cat_rental_requests = CatRentalRequest.all
    @approved_requests = @cat_rental_requests.select do |request|
      request.status == "APPROVED"
    end

    @approved_requests.each do |request|
      next if request == self
      return true if over_lapping_requests(request)
    end

    false
  end

  def over_lapping_requests(other_request)
    if self.cat_id == other_request.cat_id && self != other_request
      return (other_request.start_date.between?(self.start_date, self.end_date) ||
        other_request.end_date.between?(self.start_date, self.end_date))
    end

    false
  end

  def approve!
    transaction do
      CatRentalRequest.all.each do |request|
        if self.over_lapping_requests(request)
          request.deny!
        end
      end

      self.update(status: 'APPROVED')
    end
  end

  def deny!
    self.update(status: 'DENIED')
  end

  private

  def no_overlaps
    if over_lapping_approved_requests
      errors[:overlapping_requests] << "are not allowed."
    end
  end
end
