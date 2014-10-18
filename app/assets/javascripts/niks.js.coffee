$ ->
  $("body").on "ajax:success", ".upvote-container > a.upvote-link", (event, html) ->
    target = $(event.currentTarget)
    parent = target.parent()
    parentContainer = parent.parent()

    parent.remove()
    parentContainer.append(html)
