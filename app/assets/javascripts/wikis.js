var ready = function() {  
  
  // Live markdown preview
  var wikiTitle = document.getElementById("wiki_title");
  var wikiBody = document.getElementById("wiki_body");
  var titlePreview = document.getElementById('live_title_preview')
  var bodyPreview = document.getElementById('live_body_preview')

  var wikiEdited = false;
  var formSubmitted = false;

  if (bodyPreview || titlePreview) {
    titlePreview.innerHTML = markdown.toHTML(wikiTitle.value);
    bodyPreview.innerHTML = markdown.toHTML(wikiBody.value);

    try{
        wikiTitle.onkeyup = wikiTitle.onkeypress = function(){
            titlePreview.innerHTML = markdown.toHTML(this.value);

            if(!wikiEdited) {
              wikiEdited = true;
            }
        }
        wikiBody.onkeyup = wikiBody.onkeypress = function(){
            bodyPreview.innerHTML = markdown.toHTML(this.value);

            if(!wikiEdited) {
              wikiEdited = true;
            }
        }
    }
    catch(e){}
  }

  // Confirm before leaving page if data is entered unless form submitted
  window.onbeforeunload = function() {
    if(wikiEdited && !formSubmitted) {
      return "Changes have been made. Are you sure you want to redirect?";
    }
  };

  $("form").submit(function() {
      formSubmitted = true;
  });

  // Load the add collaborators form for new and edit pages only if the private checkbox is clicked
  var collaboratorsSection = $("#collaborators_section");
  var removalWarning = $("#removal_warning");
  var checkbox = $("#wiki_private");
  var toggleMe = $(".toggle_me");
  var keepOpen = $("#keep_open");

  $(function() {
    if (checkbox.is(':checked')) {
      collaboratorsSection.toggleClass("hidden");
      keepOpen.toggleClass("hidden");
      removalWarning.addClass("hidden")
    }
  });

  checkbox.on('change', function() {
    toggleMe.each( function() {
      $(this).toggleClass("hidden");
    });
  });


  // Keep sidebar's collaborators list from closing unless explicitly closed
  // i.e. clicking somewhere on the page won't close it
  $('#keep_open').on({
      "shown.bs.dropdown": function() { this.closable = false; },
      "click":             function() { this.closable = true; },
      "hide.bs.dropdown":  function() { return this.closable; }
  });

};


$(document).ready(ready)
// $(document).on('turbolinks:load', ready);  

