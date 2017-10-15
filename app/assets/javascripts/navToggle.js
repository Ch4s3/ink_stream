document.addEventListener('turbolinks:load', function() {
  
  const mobileMenu = document.querySelector('.mobile-menu');
  const toggle = document.querySelector('.nav-toggle');
  const screen = document.querySelector('.screen');
  toggle.onclick = function(e){
    if (mobileMenu.classList && !mobileMenu.classList.contains('active')) {
      mobileMenu.classList.remove('slide-back');
      mobileMenu.classList.add('active');
      screen.classList.add('overlay');
    }
  }
  
  document.addEventListener('click', function(event) {
    const clickedOnToggle = toggle.contains(event.target);
    const isClickInside = mobileMenu.contains(event.target);
    const menuActive = mobileMenu.classList.contains('active');
    if (!isClickInside && !clickedOnToggle && menuActive) {
      mobileMenu.classList.remove('active');
      mobileMenu.classList.add('slide-back');
      screen.classList.remove('overlay');
    }
  });
})