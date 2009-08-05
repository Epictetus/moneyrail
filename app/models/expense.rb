class Expense < Item
  # associations
  
  belongs_to :account
  
  # validations

  validates_presence_of :account

  def find_conflict
    Expense.first(:conditions => {
      :date => date, 
      :account_id => account_id,
      :category_id => category_id,
      :position => position,
    })
  end
  
  # featues

  acts_as_list :scope => [
    'date => #{date}',
    'account_id => #{account_id}',
    'category_id => #{category_id}',
  ].join(" AND ")
end
