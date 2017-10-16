document.addEventListener('turbolinks:load', function() {
  const mobileMenu = document.querySelector('.mobile-menu');
  const toggle = document.querySelector('.nav-toggle');
  const screen = document.querySelector('.screen');

  menuActive = function() { return mobileMenu.classList.contains('active'); }

  showNav = function() {
    mobileMenu.classList.remove('slide-back');
    mobileMenu.classList.add('active');
    screen.classList.add('overlay');
  }

  hideNav = function() {
    mobileMenu.classList.remove('active');
    mobileMenu.classList.add('slide-back');
    screen.classList.remove('overlay');
  }

  toggle.onclick = function(e){
    if (mobileMenu.classList && !mobileMenu.classList.contains('active')) {
      showNav();
    }
  }

  // TouchEvent listener https://developer.mozilla.org/en-US/docs/Web/API/TouchEvent/touches
  document.addEventListener('touchstart', function(event) {
    const touchedToggle = toggle.contains(event.target);
    const isTouchInside = mobileMenu.contains(event.target);
    if (menuActive() && !isTouchInside && !touchedToggle) {
      hideNav();
    }
  });
  
  document.addEventListener('click', function(event) {
    const clickedOnToggle = toggle.contains(event.target);
    const isClickInside = mobileMenu.contains(event.target);
    if ( menuActive() && !isClickInside && !clickedOnToggle) {
      hideNav();
    }
  });
})