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
    {
      is_current: @nik == nik,
      url: nik_path(nik),
      name: nik.path,
      title: nik.title,
      body: nik.body,
      parent: "null",
      children: get_children(nik),
      branches: root.last_leaves.count
    }
  end

  def get_children(parent)
    parent.children.map do |child|
      node(child)
    end
  end
end
