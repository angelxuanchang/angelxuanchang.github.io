this.util = {
  hasField: (obj, field, values) ->
    if obj[field]
       ovs = obj[field]
       if typeof(ovs) == 'string'
         ovs = ovs.split(',')
       if not Array.isArray(values)
         values = [values]
       return !values.every((v) -> ovs.indexOf(v) < 0)
    return false

  showPubs: (field, values) ->
    if not Array.isArray(values)
      values = [values]
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

  showAllPubs: () ->
    $('.paper').each((x,i) -> 
      $(this).show()
    )
    $('.year').each((x,i) ->
      $(this).show()
    )
}