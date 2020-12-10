<template>
  <div id="register" class="text-center">
    <login-register-header />
    <form class="form-register" @submit.prevent="register">
      <h1 class="h3 mb-3 font-weight-normal">Create Account</h1>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">
        {{ registrationErrorMsg }}
      </div>
      <div class="input">
        <label for="username" class="sr-only">Username </label>
        <input
          type="text"
          id="username"
          class="form-control"
          placeholder="Username"
          v-model="user.username"
          required
          autofocus
        />
      </div>
      <div class="input">
        <label for="password" class="sr-only">Password </label>
        <input
          type="password"
          id="password"
          class="form-control"
          placeholder="Password"
          v-model="user.password"
          required
        />
        <input
          type="password"
          id="confirmPassword"
          class="form-control"
          placeholder="Confirm Password"
          v-model="user.confirmPassword"
          required
        />
      </div>
      <br>
      <div>
        <input type="radio" name="role" v-model="user.role" v-bind:value="'user'">
        <label for="user">Student</label>
        <input type="radio" name="role" v-model="user.role" v-bind:value="'teacher'">
        <label for="user">Instructor</label>
        <br>
        <br>
        <br>
      </div>
      <button class="btn btn-lg btn-primary btn-block" type="submit">
        Create Account
      </button>
      <div><router-link :to="{ name: 'login' }">Have an account?</router-link></div>
    </form>
  </div>
</template>

<script>
import LoginRegisterHeader from '../components/LoginRegisterHeader.vue';
import authService from '../services/AuthService';

export default {
  components: { LoginRegisterHeader },
  name: 'register',
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        role: '',
      },
      registrationErrors: false,
      registrationErrorMsg: 'There were problems registering this user.',
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = 'Password & Confirm Password do not match.';
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: '/login',
                query: { registration: 'success' },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = 'Bad Request: Validation Errors';
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = 'There were problems registering this user.';
    },
  },
};
</script>

<style>
.input {
  margin-bottom: 10px;
}

.form-register {
  border: solid rgb(155, 180, 202);
}
</style>
