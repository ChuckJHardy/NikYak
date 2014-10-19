$ ->
  $("body").on "ajax:success", ".story-intro-actions > a.upvote-link", (event, html) ->
    $('.vote-container').text(html)

  $(".zoom").on "click", (event) ->
    event.preventDefault()
    $("html, body").animate
      scrollTop: $(".tree-outer-container").offset().top
    , 500
    return
