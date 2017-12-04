class CaptureTransaction
  require 'pagarme'

  def self.call(payment_id)
    new(payment_id).call
  end

  attr_reader :payment_id, :status

  def initialize(payment_id)
    @payment_id = payment_id
    @status = true

    PagarMe.api_key = ENV["PAGARME_API_KEY"]
  end

  def call
    @status = false unless capture(transaction(payment))
  end

  private

  def payment(payment_id)
    # find payment
    payment = Payment.find_by(id: @payment_id)
  end

  def transaction(payment)
    # find transaction
    transaction = PagarMe::Transaction.find(payment.transaction_id)
  end

  def capture(transaction)
    # capture transaction
    # TODO insert metadata here
    transaction.capture(amount: payment.value)
  end
end
