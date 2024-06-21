(function() {
  var dehighlightPubPills, highlightPubPills;

  dehighlightPubPills = function() {
    return $('.pub_badge').removeClass('active');
  };

  highlightPubPills = function(tags) {
    return tags.forEach(function(t) {
      return $('#pub_' + t).addClass('active');
    });
  };

  this.util = {
    hasField: function(obj, field, values) {
      var ovs;
      if (obj[field]) {
        ovs = obj[field];
        if (typeof ovs === 'string') {
          ovs = ovs.split(',');
        }
        if (!Array.isArray(values)) {
          values = [values];
        }
        return !values.every(function(v) {
          return ovs.indexOf(v) < 0;
        });
      }
      return false;
    },
    showPubs: function(field, values) {
      if (!Array.isArray(values)) {
        values = [values];
      }
      dehighlightPubPills();
      highlightPubPills(values);
      $('.year').each(function(x, i) {
        return $(this).show();
      });
      $('.paper').each(function(x, i) {
        var d;
        d = $(this).data();
        if (util.hasField(d, field, values)) {
          return $(this).show();
        } else {
          return $(this).hide();
        }
      });
      return $('.year').each(function(x, i) {
        if ($(this).find('.paper:visible').size() > 0) {
          return $(this).show();
        } else {
          return $(this).hide();
        }
      });
    },
    showAllPubs: function() {
      dehighlightPubPills();
      highlightPubPills(['all']);
      $('.paper').each(function(x, i) {
        return $(this).show();
      });
      return $('.year').each(function(x, i) {
        return $(this).show();
      });
    }
  };

}).call(this);
