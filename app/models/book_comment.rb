class BookComment < ApplicationRecord

  belongs_to :user
  belongs_to :book


  validates :commment ,presence:true

end
