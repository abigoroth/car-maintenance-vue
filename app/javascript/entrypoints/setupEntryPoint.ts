import { Component, createApp } from 'vue';
// 'bootstrap-vue' still not compatible with vue3, need to wait for upgrade
// import { BootstrapVue, IconsPlugin } from 'bootstrap-vue';
import { Router } from 'vue-router';
import { VueQueryPlugin } from 'vue-query';
// import OneSignalVuePlugin from '@onesignal/onesignal-vue3';
// import Vuetify from 'vuetify';
import { createVuetify } from 'vuetify';
import * as components from 'vuetify/components';
import * as directives from 'vuetify/directives';
import { aliases, mdi } from 'vuetify/iconsets/mdi';
import { globalProperties } from './globalProperties';
import { pinia } from '@/stores';
import { setHTTPHeader } from '@/services/http.service';
import AuthService from '@/services/auth.service';
import 'vuetify/lib/styles/main.css';
import '@mdi/font/css/materialdesignicons.css';

const token = AuthService.getToken();
// Vuetify
const vuetify = createVuetify({
  icons: {
    defaultSet: 'mdi',
    aliases,
    sets: {
      mdi,
    },
  },
  components,
  directives,
});

if (token) {
  setHTTPHeader({ Authorization: token });
}

export const setupEntryPoint = (rootComponent: Component, router: Router) => {
  const app = createApp(rootComponent);

  app.use(router);
  app.use(pinia);
  app.use(VueQueryPlugin);
  app.use(vuetify);
  // onesignal is loaded somewhere else.
  // app.use(OneSignalVuePlugin, {
  //   appId: 'df76982b-a7a9-4ebb-8a79-7d9b722f8d95',
  // });

  // still not compatible with vue3, need to wait for upgrade
  // app.use(BootstrapVue);
  // app.use(IconsPlugin);

  app.config.globalProperties = { ...app.config.globalProperties, ...globalProperties };

  app.mount('#app');
};
