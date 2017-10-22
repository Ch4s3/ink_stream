removeFlash = function removeFlash(e) {
  const flashEl = e.target.parentNode;
  flashEl.parentNode.removeChild(flashEl);
}