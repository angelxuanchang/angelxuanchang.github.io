dehighlightPubPills = () ->
  $('.pub_badge').removeClass('active')

highlightPubPills = (tags) ->
  tags.forEach((t) -> $('#pub_' + t).addClass('active'))

this.util = {
  hasField: (obj, field, values) ->
    if obj[field]
       ovs = obj[field]
       if typeof(ovs) == 'string'
         ovs = ovs.split(',')
       if typeof(values) == 'string'
         values = values.split(',')
       return !values.every((v) -> ovs.indexOf(v) < 0)
    return false

  hasAllFields: (obj, field, values) ->
    if obj[field]
       ovs = obj[field]
       if typeof(ovs) == 'string'
         ovs = ovs.split(',')
       if typeof(values) == 'string'
         values = values.split(',')
       return values.every((v) -> if v.startsWith('!') then ovs.indexOf(v.slice(1)) < 0 else ovs.indexOf(v) >= 0)
    return false

  hasSet: (obj, field, sets) ->
    if obj[field]
       if not Array.isArray(sets)
         sets = [sets]
       return !sets.every((vs) -> !util.hasAllFields(obj, field, vs)) 
    return false

  showPubs: (field, values) ->
    if not Array.isArray(values)
      values = [values]
    dehighlightPubPills()
    highlightPubPills(values)
    $('.year').each((x,i) ->
      $(this).show()
    )
    $('.paper').each((x,i) -> 
      d = $(this).data()
      if util.hasField(d, field, values)
        $(this).show()
      else
        $(this).hide()
    )
    $('.year').each((x,i) ->
      if $(this).find('.paper:visible').size() > 0
        $(this).show()
      else
        $(this).hide()
    )

  showPubsInTopic: (topic, tagsets) ->
    if not Array.isArray(tagsets)
      tagsets = [tagsets]
    dehighlightPubPills()
    $('.year').each((x,i) ->
      $(this).show()
    )
    $('.paper').each((x,i) -> 
      d = $(this).data()
      if util.hasSet(d, 'tags', tagsets)
        $(this).show()
      else
        $(this).hide()
    )
    $('.year').each((x,i) ->
      if $(this).find('.paper:visible').size() > 0
        $(this).show()
      else
        $(this).hide()
    )

  showAllPubs: () ->
    dehighlightPubPills()
    highlightPubPills(['all'])
    $('.paper').each((x,i) -> 
      $(this).show()
    )
    $('.year').each((x,i) ->
      $(this).show()
    )
}