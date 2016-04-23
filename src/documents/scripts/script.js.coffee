$ ->
  printPub = (p) ->
    text = p.title + "<br>"
    for author in p.authors
      text += author + ", "
    text += "<br>"
    text
