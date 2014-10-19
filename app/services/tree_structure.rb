class TreeStructure
  include Rails.application.routes.url_helpers

  class << self
    def structure(nik)
      new(nik).structure
    end
  end

  def initialize(nik)
    @nik = nik
  end

  def structure
    [node(root)]
  end

  private
  def root
    @root ||= @nik.root || @nik
  end

  def node(nik)
    attributes = {
      id: nik.id,
      is_current: @nik == nik,
      url: nik_path(nik),
      body: nik.body[0..55],
      parent: nik.parent.try(:id),
      children: get_children(nik),
      branches: root.last_leaves.count
    }

    attributes.merge!(current_path: path_ids) if nik.root?

    attributes
  end

  def get_children(parent)
    parent.children.map do |child|
      node(child)
    end
  end

  def path_ids
    @nik.first_branch.map(&:id)
  end
end
