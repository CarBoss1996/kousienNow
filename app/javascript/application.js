import 'jquery';
import Rails from '@rails/ujs';
import "@hotwired/turbo-rails"
import * as bootstrap from "bootstrap/dist/js/bootstrap"
import 'admin-lte/build/js/AdminLTE'
import './loading'
import './user_location';
import './post';
import './like_post';
import './location';
import './guide';
import './location_modal';
import './email_prompt_modal';
import './post_modal';

window.bootstrap = bootstrap;

Rails.start();
