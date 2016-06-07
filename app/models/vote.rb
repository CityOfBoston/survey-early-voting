class Vote < ActiveRecord::Base
  belongs_to :location, counter_cache: true
  after_save :notify_pusher

  validates :location, presence: true

  obfuscate_id

  private

  def notify_pusher
    Pusher['dashboard'].trigger('update', {
      :vote_count => self.location.votes.count,
      :id => self.location.id
    })
  end
end
