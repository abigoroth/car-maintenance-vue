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
  theme: {
    defaultTheme: 'myCustomTheme',
    themes: {
      myCustomTheme: {
        dark: true,
        colors: {
          background: '#1c1b1b',
          surface: '#312a2a',
          'surface-bright': '#413f3f',
          'surface-light': '#4b4747',
          'surface-variant': '#424242',
          'on-surface-variant': '#565656',
          primary: '#364c79',
          'primary-darken-1': '#29384b',
          secondary: '#496275',
          'secondary-darken-1': '#2b3844',
          error: '#B00020',
          info: '#2196F3',
          success: '#4c68af',
          warning: '#FB8C00',
        },
        variables: {
          'border-color': '#000000',
          'border-opacity': 0.12,
          'high-emphasis-opacity': 0.87,
          'medium-emphasis-opacity': 0.6,
          'disabled-opacity': 0.38,
          'idle-opacity': 0.04,
          'hover-opacity': 0.04,
          'focus-opacity': 0.12,
          'selected-opacity': 0.08,
          'activated-opacity': 0.12,
          'pressed-opacity': 0.12,
          'dragged-opacity': 0.08,
          'theme-kbd': '#212529',
          'theme-on-kbd': '#383737',
          'theme-code': '#626262',
          'theme-on-code': '#000000',
        },
      },
    },
  },
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
