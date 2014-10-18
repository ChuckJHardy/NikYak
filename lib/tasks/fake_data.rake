namespace :db do
  task :populate_niks => [:environment] do

    def add_children(parent, node)
      new_parent = if parent.nil?
        Nik.create(
          parent_id: nil,
          body: node[:content],
          title: node[:title],
          votes: rand(10)
        )
      else
        Nik.create(
          parent_id: parent.id,
          body: node[:content],
          votes: rand(10)
        )
      end

      Array.wrap(node[:children]).each { |child_node| add_children(new_parent, child_node) }
    end

    [
      {
        content: "Introduction #1",
        title: "Introduction #1",
        children: [
          { content: "Introduction #1 child 1" },
          {
            content: "Introduction #1 child 2",
            children: [
              { content: "Introduction #1 child 2 child 1" },
              { content: "Introduction #1 child 2 child 2" }
            ]
          },
          { content: "Introduction #1 child 3" },
          { content: "Introduction #1 child 4" },
          {
            content: "Introduction #1 child 5", children: [
              { content: "Introduction #1 child 5 child 1" },
              { content: "Introduction #1 child 5 child 2" },
              {
                content: "Introduction #1 child 5 child 3",
                children: [
                  { content: "Introduction #1 child 5 child 3 child 1" },
                  { content: "Introduction #1 child 5 child 3 child 2" }
                ]
              }
            ]
          }
        ]
      },
      {
        content: "Introduction #2",
        title: "Introduction #2",
        children: [
          { content: "Introduction #2 child 1" },
          {
            content: "Introduction #2 child 2",
            children: [
              { content: "Introduction #2 child 2 child 1" },
              { content: "Introduction #2 child 2 child 2" }
            ]
          },
          { content: "Introduction #2 child 3" },
          { content: "Introduction #2 child 4" },
          {
            content: "Introduction #2 child 5", children: [
              { content: "Introduction #2 child 5 child 1" },
              { content: "Introduction #2 child 5 child 2" },
              {
                content: "Introduction #2 child 5 child 3",
                children: [
                  { content: "Introduction #2 child 5 child 3 child 1" },
                  { content: "Introduction #2 child 5 child 3 child 2" }
                ]
              }
            ]
          }
        ]
      }
    ].each do |story|
      add_children(nil, story)
    end
  end
end
