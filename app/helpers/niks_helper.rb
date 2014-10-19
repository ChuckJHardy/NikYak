module NiksHelper
  def random_change_link_left
    [
      "< Not for me",
      "< Go Back",
      "< This way Bro"
    ].shuffle.first
  end

  def random_change_link_right
    [
      "Something has changed >",
      "The Story has deviated >",
      "What is happening over here? >"
    ].shuffle.first
  end

  def random_change_link_vote
    [
      "Show some love",
      "Vote",
      "Do you think this is any good?"
    ].shuffle.first
  end

  def random_change_link_what_now
    [
      "What happens next?",
      "This is getting exciting! Now what?",
      "Wrap it up!",
      "I can hardly wait to see what happens next!",
      "I'm on the edge of my seat! I can't imagine what's going to happen!"
    ].shuffle.first
  end
end
