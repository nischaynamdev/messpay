class Resident < ApplicationRecord
  belongs_to :hostel
  has_one :account,dependent: :delete
  has_many :leaves,dependent: :delete_all
  has_one :user,dependent: :delete
  validates :room_number,presence: true,uniqueness: {case_sensitive: false}
  validates :roll_number,presence: true,uniqueness:{case_sensitive: false}
  validates :name, presence: true,length:{ maximum: 50 }
  after_create :make_account
  private

  def make_account
    Account.create(fine:0,leaves:0,last_month_adjustment:0,resident_id:self.id)
  end

end
