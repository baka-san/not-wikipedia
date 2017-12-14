var ready = function() {  
  
  var wikiBody = document.getElementById("wiki_body");
  var livePreview = document.getElementById('live_wiki_preview')
  if (livePreview) {
    livePreview.innerHTML = markdown.toHTML(wikiBody.value);

    try{
        wikiBody.onkeyup = wikiBody.onkeypress = function(){
            livePreview.innerHTML = markdown.toHTML(this.value);
        }
    }
    catch(e){}
  }
};

$(document).on('turbolinks:load', ready);  