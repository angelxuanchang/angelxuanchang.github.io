fs = require 'fs'

groupBy = (array, key) ->
  return array.reduce( (obj, element) -> 
    v = if (typeof(key) == 'function') then key(element) else element[key]
    obj[v] = obj[v] || []
    obj[v].push(element)
    return obj
  , {})

hasField = (obj, field, values) ->
  if obj[field]
     if not Array.isArray(values)
       values = [values]
     return !values.every((v) -> obj[field].indexOf(v) < 0)
  return false
hasAllFields = (obj, field, values) ->
  if obj[field]
     if not Array.isArray(values)
       values = [values]
     t = obj[field]  
     return values.every((v) -> if v.startsWith('!') then t.indexOf(v.slice(1)) < 0 else t.indexOf(v) >= 0)
  return false
hasSet = (obj, field, sets) ->
  if obj[field]
     if not Array.isArray(sets)
       sets = [sets]
     return !sets.every((vs) -> !hasAllFields(obj, field, vs)) 
  return false

docpadConfig = {
  templateData:
    site:
      title: "Angel Xuan Chang"
      author: "Angel Xuan Chang"
      email: "angelx@cs.stanford.edu"
      description: "Angel Xuan Chang's Homepage"
      styles: [
        "/styles/twitter-bootstrap.css"
        "/styles/style.css"
      ]
      scripts: [
        "//cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.min.js"
        "//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min.js"
        "/scripts/bootstrap.min.js"
        "/scripts/script.js"
      ]
    groupBy: groupBy
    hasField: hasField
    hasAllFields: hasAllFields
    hasSet: hasSet
    news: JSON.parse(fs.readFileSync("src/data/news.json"))
    pubs: JSON.parse(fs.readFileSync("src/data/pubs.json"))
    people: JSON.parse(fs.readFileSync("src/data/people.json"))
    topics: JSON.parse(fs.readFileSync("src/data/topics.json"))
    maintags: ['nlp', 'vision', 'graphics', 'hci'],
    getPreparedTitle: ->
      if @document.title then "#{@document.title} | #{@site.title}" else @site.title
  plugins:
    ghpages:
      deployRemote: 'origin'
      deployBranch: 'master'
    downloader:
      downloads: [
        {
          name: 'Bootstrap'
          path: 'download/twitter-bootstrap'
          url: 'https://codeload.github.com/twbs/bootstrap/tar.gz/v3.3.7'
          tarExtractClean: true
        }
      ]
    copy:
      'boostrap-fonts':
          src: '../download/twitter-bootstrap/dist/fonts'
          out: 'fonts'
      'bootstrap-js':
          src: '../download/twitter-bootstrap/dist/js'
          out: 'scripts'
}

module.exports = docpadConfig
