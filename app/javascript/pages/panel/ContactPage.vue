<template>
  <h2 class="text-center">Contact</h2>
  <ul class="navbar-nav">
    <li class="nav-item">
      <a
        href="https://wa.me/60172931521?text=Servoti+Help"
        target="_blank"
        class="btn btn-primary d-flex"
      >
        Whatsapp
      </a>
    </li>
    <li class="nav-item btn btn-danger" @click="requestPermission">Notification</li>
    <li class="nav-item btn btn-danger" @click="getOsId">getOsId</li>
    <li class="nav-item btn btn-danger" @click="logout">Logout</li>
  </ul>
</template>
<script>
import axios from 'axios';
import { useAuthStore } from '@/stores/auth.store';
import { showToast } from '@/utils/showToast';
const authStore = useAuthStore();
// import OneSignalVuePlugin from '@onesignal/onesignal-vue3';

const logout = () => {
  authStore.logout();
};

function requestPermission() {
  console.log('Requesting permission...');
  Notification.requestPermission().then((permission) => {
    if (permission === 'granted') {
      const granted_msg = 'Notification permission granted.';
      console.log(granted_msg);
      alert(granted_msg);
    } else {
      alert('Permission: ' + permission);
    }
  });
}

export default {
  name: 'App',
  methods: {
    async getOsId() {
      const os_sub_id = localStorage.getItem('os_sub_id');
      const os_app_id = localStorage.getItem('os_app_id');
      const userId = localStorage.getItem('userId');
      const id = await axios.get(
        'https://api.onesignal.com/apps/' +
          os_app_id +
          '/subscriptions/' +
          os_sub_id +
          '/user/identity',
      );
      const os_id = id.data.identity.onesignal_id;
      console.log(id);
      localStorage.setItem('os_id', os_id);
      console.log(authStore);
      const formData = new FormData();
      formData.append('os_id', os_id);
      axios
        .put('/api/v1/users/' + userId, formData, {})
        .then(() => {
          showToast('OS id stored', 'success');
        })
        .catch((error) => {
          console.log(error);
          showToast(error.response.data.errors[0], 'error');
        });
      //   store os_id in backend
      //   update external id into onesignal
      // send notification hapily.. :P
      // https://documentation.onesignal.com/reference/create-alias-by-subscription
    },
  },
};
</script>
