class ViewCount < ApplicationRecord
  def self.increment(path)
    view_count = ViewCount.find_or_create_by(path: path)
    self.increment_counter(:views, view_count.id, touch: true)
  end
end
