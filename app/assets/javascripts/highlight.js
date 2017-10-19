document.addEventListener('turbolinks:load', function() {
  const articleText = document.querySelector('.article-text');
  if(articleText) {
    articleText.addEventListener('mouseup', function(e) {
      data = getText(e);
      if(data) {console.log(data);}
    }, false);
  }
});
