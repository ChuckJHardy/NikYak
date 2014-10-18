class TreeStructure
  class << self
    def structure(nik)
      [
        {
          name: "Top Level",
          parent: "null",
          children: [
            {
              name: "Level 2: A",
              parent: "Top Level",
              children: [
                {
                  name: "Son of A",
                  parent: "Level 2: A"
                },
                {
                  name: "Daughter of A",
                  parent: "Level 2: A"
                }
              ]
            },
            {
              name: "Level 2: B",
              parent: "Top Level"
            }
          ]
        }
      ]
    end

    def structure2(nik)
      root = nik.root || nik

      [{ name: name(root), body: root.body, parent: "null", children: get_children(root) }]
    end

    def get_children(parent)
      puts parent.inspect
      parent.children.map do |child|
        { name: name(child), body: child.body, parent: name(parent), children: get_children(child) }
      end
    end

    def name(node)
      if node.title
        "#{node.title}-#{node.id}"
      else
        "#{node.body[0..55]}-#{node.id}"
      end
    end
  end
end
