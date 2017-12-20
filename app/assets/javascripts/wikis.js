var ready = function() {  
  
  var wikiTitle = document.getElementById("wiki_title");
  var wikiBody = document.getElementById("wiki_body");
  var titlePreview = document.getElementById('live_title_preview')
  var bodyPreview = document.getElementById('live_body_preview')

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
  var checkbox = $("#wiki_private");
  var collaboratorsForm = $("#collaborators_form");

  checkbox.on('change', function() {
    if (this.checked) {
      collaboratorsForm.removeClass("hidden");
    }
    else {
      collaboratorsForm.addClass("hidden");
    }
  });

  // Pushing enter in collaborator search box renders a user or error
  var collaboratorsSearchBar = $("#wiki_collaborations_attributes_0_user_id");
  var collaboratorsSubmitBtn = $("#collaborators_search_btn");

  collaboratorsSearchBar.on('keypress', function(event) {
    if(event.keyCode == 13) {
      event.preventDefault();
      collaboratorsSubmitBtn.click();
    }
  });

  collaboratorsSubmitBtn.on('click', function(event) {
      alert('hello');

      // search for the email in collaboratorsSearchBar
      // if email is found in ActiveRecord User model
        // append a div displaying email text to page WITHOUT reloading page
          // send AJAX request with email as a param. In the controller @collaborator = 
        // add a hidden form tag to the form containing the user info to be handled by controller
        // clear out collaboratorsSearchBar so it can be used to search for another user
      // if no email
        // display "no such user" error
        // clear out collaboratorsSearchBar so it can be used to search for another user
  });

  // function searchCollaborator(email) {
  //   var userId = User.where(email: email).id
  //   $.ajax({
  //     url: ""

  //   })

  // }


};


$(document).on('turbolinks:load', ready);  