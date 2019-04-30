module Subscribe::UserSubscribings
  def self.find(current_user)
    User.joins(:subscribers).where('subscribing_id = ?', current_user.id)
  end
end
