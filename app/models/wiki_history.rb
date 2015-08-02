class WikiHistory < ActiveRecord::Base
  paginates_per 10

  belongs_to :wiki
  belongs_to :knowledge, counter_cache: true
  belongs_to :commit, class_name: 'User', foreign_key: 'commit_id'
  validates :commit_id, presence: true
  validates :active, uniqueness: { scope: :knowledge_id }

  enum status: [:status_initial, :status_passed]

  def set_active
    self.class.where.not(id: self.id).where(knowledge_id: self.knowledge_id).update_all(active: false)
    self.update(active: true)
    move_to_wiki
  end

  def move_to_wiki
    wiki = knowledge.wiki || knowledge.build_wiki
    wiki.commit_id = self.commit_id
    wiki.commit_message = self.commit_message
    wiki.body = self.body
    wiki.save
  end

end

# :item_id, :integer
# :user_id, :integer
# :content, :string, limit: 65535
# :comment, :string
