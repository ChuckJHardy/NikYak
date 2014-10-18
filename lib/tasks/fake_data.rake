namespace :db do
  task :populate_niks => [:environment] do

    def add_children(parent, node)
      new_parent = if parent.nil?
        Nik.create(
          parent_id: nil,
          body: node[:content],
          title: node[:title],
          votes: rand(10),
          user_id: User.first.id
        )
      else
        Nik.create(
          parent_id: parent.id,
          body: node[:content],
          votes: rand(10),
          user_id: User.first.id
        )
      end

      Array.wrap(node[:children]).each { |child_node| add_children(new_parent, child_node) }
    end

    [
      {
        content: "At the sound of my name, my head snapped up, eyes going wide for a moment. The coach looked around, though he knew exactly who I was. With my heart beating quickly in my chest, and sweaty palms despite the cool air of the rink, I cleared my throat and held up my hand awkwardly. He gave me a quick grin and nodded, checking my name off his paper.",
        title: "Stolen Jerseys",
        children: [
          { content: "Coach Monroe went through the rest of the names, rather quickly, and I made a mental check with each one, trying to place a name with each guy surrounding me. I could feel my nerves creeping up - especially each time one of the guys smirked and grinned proudly, knowing that he had a spot on the team." },
          {
            content: "Despite standing on the ice of the Marlies stadium, I could barely believe what was happening to me. The week after I graduated high school, the Marlies' coach (James Monroe, a large, scary looking guy) had come to my house and told me that I had been recruited from the Marlies. Being recruited for one of the minor league teams in Toronto was ",
            children: [
              { content: "The Maple Leafs' coach came to the Marlies games to scout for new players for their team." },
              { content: "And now? Now I was trying out for a team that the Leafs." }
            ]
          },
          { content: "Split into teams of two,\" Coach ordered, stomping his booted foot against the ice, \"fifteen players on each, plus one goalie. Ten on the ice at a time, and every fifteen minutes we'll switch out the offensive and defensive players!" },
          { content: "Everyone split into teams quickly. I skated over to the left side of the rink, where a huge guy I had remembered to be Dan stood. I awkward stood next to him, and waited for the Coach's instructions. He just turned and whistled, leaving us to figure out who stayed on the ice or not - which was absolutely awful, since no one had really talked with each other." },
          {
            content: "In the end, I and nine other players stood on the ice. A bigger guy went into the position of goalie, and the last five of our team made their way over to the bleachers. None of us knew each others skills, and I sighed quietly, pulling my helmet over my messy hair. I knew I'd have to give right now my everything, since that was how Monroe was going to determine who he wanted.", children: [
              { content: "I shoved the mouthpiece halfway into my mouth; I knew in hockey you were supposed to keep it in all the way - safety reasons - but I couldn't stand the feel of it. Rolling my shoulders back, I cleared my mind of the safety of mouth-guards and focused on the game in front of us." },
              { content: "Dan was up at the middle, slapping sticks with the guy in front of him as they counted down until the game. I leaned forward; I was on the offensive team, with a few other guys. I didn't focus on anything else but the two guys in front of me, my eyes locked on the puck only a bit away. A few slides and I'd be right there.." },
              {
                content: "The next three-and-a-half (almost four) hours were absolute hell.",
                children: [
                  { content: "I had never seen a coach yell as much as Monroe did. He yelled for every reason; whether he was cheering on the team he preferred at the moment, or yelling at someone for whatever mistakes they made. I'm almost certain that without my helmet, and the noise of the puck being hit around, and my skates sliding everywhere, I would've gone fucking deaf." },
                  { content: "And even the game itself was hell, at that. Everyone was fighting for a position on the team, meaning everyone was trying as hard as they possibly could. Everybody had been checking each other (I was guilty of it), and on more than one occasion, a few players had sat out due to busted noses or lips. The game had such little rules, making it as close to a free-for-all as it could be." }
                ]
              }
            ]
          }
        ]
      },
      {
        content: "Come on, Julie, you're going to be late if you aren't careful. You know I was never late,\" Julie finished. \"Yes, Aunt Evie, I know. I'm meeting new clients at The Rose Chalet today and I really want to make a good impression. Do I look okay?",
        title: "The Wedding Gift",
        children: [
          { content: "Julie's aunt was in her sixties now, with gray hair and a slight stoop caused by too many years of bending over hot stoves. But she still looked good for her age, and she still had that same no-nonsense attitude she'd had when Julie was a child." },
          {
            content: "Even though Julie was twenty-eight now, Evie still didn't hesitate to wipe off a spot of smudged makeup from her cheek.",
            children: [
              { content: "You look lovely, sweetheart." },
              { content: "Are you sure?" }
            ]
          },
          { content: "Julie checked her appearance in the mirror hanging by the door one more time, knowing everything had to be perfect for today. She usually tied her dark hair back when she was cooking, but she'd left it down this morning, knowing she made a better impression on strangers when it was falling down around her shoulders. She'd decided on a simple combination of a navy-blue sweater and dark pants for the day, because they were practical enough to cook in while still looking professional." },
          { content: "Aunt Evie nodded. \"Of course I'm sure. Though you could do with putting on a few pounds. Whoever heard of a thin cook?\"" },
          {
            content: "This from the woman who wouldn't dream of missing her exercise class twice a week?\" Julie laughed. She glanced at her reflection again and ran one hand over her hair. \"Maybe if I I'm not going to stand here complimenting you when you should already be on your way to work,\" Aunt Evie said. \"You have had breakfast, haven't you?", children: [
              { content: "\"I'll get something later,\" Julie promised." },
              { content: "\"Probably from one of those food trucks you seem to love so much.\" Her aunt harrumphed." },
              {
                content: "Julie gave her aunt a kiss on the cheek, then ran out to the car she was borrowing. Her beloved Mustang had gone the way of her old apartment, sucked away by debts when the restaurant went under.",
                children: [
                  { content: "Julie wove through traffic, hoping she wouldn't be stopped while she completely ignored the speed limit in an effort to be on time. As Aunt Evie had pointed out, she had never been late in all the time she'd worked at The Rose Chalet, and Julie now had her aunt's old job...sort of." },
                  { content: "Actually she was just filling in. Rose Martin, the owner of the wedding venue, had been clear about that. She only wanted someone to help out with one wedding. Then she would start looking for someone permanent to head up the catering department at The Rose Chalet." }
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
