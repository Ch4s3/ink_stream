document.addEventListener('turbolinks:load', function() {
  const articleText = document.querySelector('.article-text');
  if(articleText) {
    articleText.addEventListener('mouseup', function(e) {
      console.log(e.target);
      console.log('click!');
    }, false);
  }
});
