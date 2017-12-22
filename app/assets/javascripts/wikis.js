var ready = function() {  
  
  // Live markdown preview
  var wikiTitle = document.getElementById("wiki_title");
  var wikiBody = document.getElementById("wiki_body");
  var titlePreview = document.getElementById('live_title_preview')
  var bodyPreview = document.getElementById('live_body_preview')

  var listFormTo12 = function() {
    currentlyCollaborating.removeClass("col-xs-12");
    currentlyCollaborating.addClass("col-xs-6");
    collaboratorsForm.removeClass("col-xs-12");
    collaboratorsForm.addClass("col-xs-6");
  };

  var listFormTo6 = function() {
    currentlyCollaborating.removeClass("col-xs-6");
    currentlyCollaborating.addClass("col-xs-12");
    collaboratorsForm.removeClass("col-xs-6");
    collaboratorsForm.addClass("col-xs-12");
  };

  if (bodyPreview || titlePreview) {
    titlePreview.innerHTML = markdown.toHTML(wikiTitle.value);
    bodyPreview.innerHTML = markdown.toHTML(wikiBody.value);

    try{
        wikiTitle.onkeyup = wikiTitle.onkeypress = function(){
            titlePreview.innerHTML = markdown.toHTML(this.value);
        }
        wikiBody.onkeyup = wikiBody.onkeypress = function(){
            bodyPreview.innerHTML = markdown.toHTML(this.value);
        }
    }
    catch(e){}
  }

  // Load the add collaborators form for new and edit pages
  var collaboratorsSection = $("#collaborators_section");
  var removalWarning = $("#removal_warning");
  var checkbox = $("#wiki_private");
  var toggleMe = $(".toggle_me");

  $(function() {
    if (checkbox.is(':checked')) {
      collaboratorsSection.toggleClass("hidden");
      removalWarning.addClass("hidden")
    }
  });

  checkbox.on('change', function() {

    // collaboratorsSection.toggleClass("hidden")
    toggleMe.each( function() {
      $(this).toggleClass("hidden");
    });
  });

  // Move the collaborators search bar above currently collaborating for very small screens
  var currentlyCollaborating = $("#currently_collaborating");
  var collaboratorsForm = $("#collaborators_form");

  if ($(window).width() < 500) {
    listFormTo6();
  }

  $(window).on('resize', function(){
    if ($(this).width() < 500) {
      listFormTo6();
    }
    else {
      listFormTo12();
    }

  });

};


$(document).ready(ready)
// $(document).on('turbolinks:load', ready);  

