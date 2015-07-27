class Item < ActiveRecord::Base
  paginates_per 10
  attachment :photo

  belongs_to :list, :counter_cache => true
  has_many :parents, class_name: 'ItemParent', :dependent => :destroy
  has_many :children, class_name: 'ItemChild', :dependent => :destroy

  # enum
  # node_top => 根节点（无父节点）
  # node_mid => 中间节点（既有父节点，亦有子节点）
  # node_bottom => 底节点（无子节点）
  enum node_type: [:node_top, :node_mid, :node_bottom]
  scope :node_tops, -> { where(node_type: node_types[:node_top]) }

  #after_save :move_to_wiki_histories

  # def move_to_wiki_histories
  #   history = WikiHistory.new
  #   history.content = self.content
  #   history.reason = self.reason
  #   history.wiki_id = self.id
  #   history.user_id = self.user_id
  #   history.save
  # end

end

# 开始属性列表
# :list_id,        :integer
# :list_name,      :string,  limit: 50
# :name,           :string,  limit: 50
# :content,        :text,    limit: 65535
# :type,           :string,  limit: 10
# :status,         :integer, default: 0
# :node_type,      :integer
# :children_count, :integer, default: 0
# :photo_id,    :string,  limit: 255

