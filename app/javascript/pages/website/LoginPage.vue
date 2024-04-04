<template>
  <div v-if="!loggedIn" class="form">
    <div class="form-box pt-25">
      <div class="form-bg py-30 px-50">
        <span class="header pb-25">Sign in to your account</span>

        <span v-if="showMessage" class="header pb-25"> You've clicked on Submit button </span>

        <form @submit.prevent="submit">
          <v-text-field
            v-model="user.email"
            v-validate="'required|email'"
            label="E-mail"
            data-vv-name="email"
            required
          ></v-text-field>

          <v-text-field
            v-model="user.password"
            :type="'password'"
            hint="At least 8 characters"
            label="Password"
            counter
          ></v-text-field>

          <div class="field pb-25">
            <input class="submit" type="submit" name="submit" value="Continue" />
          </div>
        </form>

        <div class="footer pt-25 text-center">
          <span>
            Don't have an account? <router-link :to="{ name: 'signup' }">Sign up</router-link>
          </span>
        </div>
      </div>
    </div>
  </div>
  <div v-if="loggedIn" class="text-center">Redirecting to panel</div>
</template>

<script setup lang="ts">
import { reactive, ref, onMounted, computed } from 'vue';
import axios from 'axios';
import { useRouter } from 'vue-router';
import { useAuthStore } from '@/stores/auth.store';
import { IUserLogin } from '@/types/general';
import { showToast } from '@/utils/showToast';

const authStore = useAuthStore();

const user = reactive<IUserLogin>({
  email: '',
  password: '',
});

const redirectToPanel = () => {
  window.location.href = '/panel/';
};

const showMessage = ref(false);

const loggedIn = computed(() => authStore.isAuthenticated);
const router = useRouter();

onMounted(() => {
  if (loggedIn.value) {
    axios
      .get('/check_auth')
      .then((response) => {
        if (response.status == 200) {
          redirectToPanel();
        }
      })
      .catch((error) => {
        authStore.logout();
        console.log(error.response.data.errors);
        showToast(error.response.data.errors[0], 'error');
      });
  }
});

const submit = () => {
  const os_id = localStorage.getItem('os_id');
  const os_app_id = localStorage.getItem('os_app_id');
  authStore
    .login(user)
    .then((result) => {
      const userId = result.data.id;
      localStorage.setItem('userId', userId);
      redirectToPanel();
    })
    .catch((error) => {
      showToast(error, 'error');
    });
};
</script>
