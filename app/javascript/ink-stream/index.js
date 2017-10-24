import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';

require('./removeFlash.js');
require('./getText.js');
require('./navToggle.js');

Rails.start();
Turbolinks.start();
require('./turboPatch.js');