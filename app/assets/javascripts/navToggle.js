document.addEventListener('turbolinks:load', function() {
  
  const mobileMenu = document.querySelector('.mobile-menu');
  const toggle = document.querySelector('.nav-toggle');
  toggle.onclick = function(e){
    if (mobileMenu.classList) {
      mobileMenu.classList.toggle('active');
      
    }
  }
  
  document.addEventListener('click', function(event) {
    const clickedOnToggle = toggle.contains(event.target);
    const isClickInside = mobileMenu.contains(event.target);
    const menuActive = mobileMenu.classList.contains('active');
    if (!isClickInside && !clickedOnToggle && menuActive) {
      mobileMenu.classList.toggle('active');
    }
  });
})