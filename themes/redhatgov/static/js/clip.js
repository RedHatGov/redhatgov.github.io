jQuery( document ).ready(function( $ ) {
  // clipboard
  var clipInit = false;
  $('code').each(function() {
      var code = $(this),
          text = code.text();
      
      if (text.length > 5) {
          if (!clipInit) {
              var text, clip = new Clipboard('.copy-to-clipboard', {
                  text: function(trigger) {
                      text = $(trigger).prev('code').text();
                      return text.replace(/^\$\s/gm, '');
                  }
              });

              var inPre;
              clip.on('success', function(e) {
                  e.clearSelection();
                  inPre = $(e.trigger).parent().prop('tagName') == 'PRE';
                  $(e.trigger).attr('aria-label', 'Copied to clipboard!').addClass('tooltipped tooltipped-' + (inPre ? 'w' : 's'));
              });

              clip.on('error', function(e) {
                  inPre = $(e.trigger).parent().prop('tagName') == 'PRE';
                  $(e.trigger).attr('aria-label', fallbackMessage(e.action)).addClass('tooltipped tooltipped-' + (inPre ? 'w' : 's'));
                  $(document).one('copy', function(){
                      $(e.trigger).attr('aria-label', 'Copied to clipboard!').addClass('tooltipped tooltipped-' + (inPre ? 'w' : 's'));
                  });
              });

              clipInit = true;
          }

          code.after('<span class="copy-to-clipboard" title="Copy to clipboard" />');
          code.next('.copy-to-clipboard').on('mouseleave', function() {
              $(this).attr('aria-label', null).removeClass('tooltipped tooltipped-s tooltipped-w');
          });
      }
  });
});