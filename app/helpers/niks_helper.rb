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
      "I can hardly wait to see what happens next!",
      "I'm on the edge of my seat! What's going to happen?",
      "I'll bet you know where to take this story next.",
      "What direction are you going to take this in?"
    ].shuffle.first
  end
end
