import 'jquery';
import Rails from '@rails/ujs';
import "@hotwired/turbo-rails"
import * as bootstrap from "bootstrap/dist/js/bootstrap"
import 'admin-lte/build/js/AdminLTE'
import './user_location';
import './post';
import './like_post';
import './location';
import './guide.js';
import './location_modal.js';

window.bootstrap = bootstrap;

Rails.start();
console.log('JavaScript is running');