fs = require 'fs'

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
    news: JSON.parse(fs.readFileSync("src/data/news.json"))
    pubs: JSON.parse(fs.readFileSync("src/data/pubs.json"))
    people: JSON.parse(fs.readFileSync("src/data/people.json"))
    maintags: ['nlp', 'vision', 'graphics', 'hci'],
    getPreparedTitle: ->
      if @document.title then "#{@document.title} | #{@site.title}" else @site.title
    hasField: (obj, field, values) ->
      if obj[field]
         if not Array.isArray(values)
           values = [values]
         return !values.every((v) -> obj[field].indexOf(v) < 0)
      return false
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
