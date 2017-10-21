document.addEventListener('turbolinks:load', function() {
  const toggle = document.querySelector('.nav-toggle');
  
  if (toggle) {
    const mobileMenu = document.querySelector('.mobile-menu');
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
  
    handleClickOrTouch = function(event) {
      const clickedOrTouchedToggle = toggle.contains(event.target);
      const isClickOrTouchInside = mobileMenu.contains(event.target);
      if (menuActive() && !isClickOrTouchInside && !clickedOrTouchedToggle) {
        hideNav();
      }
    }

    // TouchEvent listener https://developer.mozilla.org/en-US/docs/Web/API/TouchEvent/touches
    document.addEventListener('touchstart', function(event) {
      handleClickOrTouch(event);
    });
    
    document.addEventListener('click', function(event) {
      handleClickOrTouch(event);
    });
  }
});
