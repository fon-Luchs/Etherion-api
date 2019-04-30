module Subscribe::UserSubscribers
  def self.find(current_user)
    User.joins(:subscribings).where('subscriber_id = ?', current_user.id)
  end
end
