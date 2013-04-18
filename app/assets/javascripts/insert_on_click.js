/*
 * On click of an element, this will insert a given string of HTML data into the DOM
 * according to a selector
 *
 *  insert-content =  CGI.escapeHTML(   the HTML content you want to insert )
 *  insert-content-parent (optional) -- the value to pass into 'closest' to go up the tree
 *  insert-content-target (optional) -- the value to pass to $(this).find( ) to go down the tree
 *
 *  if you provide no content-parent or target, the content is appended to the clicked element.
 *
 *  Remember that you can use CSS jquery selectors , like :not() and :first-child, :last-child, etc. etc.
 */

(function ($) {
  $.fn.insert_content = function() {
    if (!this.length) {   return this; }
    return this.each(function() {
      var $this = $(this);
      var content = $("<div/>").html($this.data('insertContent')).text();
      var parent   = $this.data('insertContentParent');
      var selector = $this.data('insertContentTarget');

      $this.click(function(evt) {
        $this.closest(parent).find(selector).append($(content));
        evt.preventDefault();
      });
    });
  };
})(jQuery);
