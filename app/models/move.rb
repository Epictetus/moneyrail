class Move < Item
  # associations
  
  belongs_to :account_from, :class_name => "Account", :foreign_key => :account_id_from
  belongs_to :account_to, :class_name => "Account", :foreign_key => :account_id_to

  # validations

  validates_presence_of :account_from
  validates_presence_of :account_to

  def self.find_conflict(item)
    Move.all(:conditions => {
      :date => item.date,
      :account_id_from => item.account_id_from,
      :account_id_to => item.account_id_to,
      :category_id => item.category_id,
      :position => item.position,
    }).reject{|x| x.id == item.id}.first
  end

  def validate
    if account_id_from == account_id_to
      errors.add("account_id_from", "from and to must not be same")
    end
    super
  end
  
  # featues

  acts_as_list :scope => [
    'date => #{date}',
    'account_id_from => #{account_id_from}',
    'account_id_to => #{account_id_to}',
    'category_id => #{category_id}',
  ].join(" AND ")
end
