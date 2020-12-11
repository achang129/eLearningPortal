<template>
  <div id="register" class="text-center">
    <!-- <login-register-header /> -->
    <form class="form-register" @submit.prevent="register">
      <h1 class="registertext">Create Account</h1>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">
        {{ registrationErrorMsg }}
      </div>
      <div class="input">
        <label for="username" class="sr-only"></label>
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
        <label for="password" class="sr-only"></label>
        <input
          type="password"
          id="password"
          class="form-control"
          placeholder="Password"
          v-model="user.password"
          required
        />
        <br>
        <input
          type="password"
          id="confirmPassword"
          class="form-control-confirm"
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
      </div>
      <button class="btn btn-lg btn-primary btn-block" type="submit">
        Create Account
      </button>
      <div class="loginlink"><router-link :to="{ name: 'login' }">Already have an account? Login here</router-link></div>
    </form>
    <div class="login-register-gif">
        <img src="../assets/Login_RegisterGIF.gif" alt="Parthenon Logo Gif">
      </div>
  </div>
</template>

<script>
// import LoginRegisterHeader from '../components/LoginRegisterHeader.vue';
import authService from '../services/AuthService';

export default {
  components: {},
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
.registertext{
  font-family: Georgia, 'Times New Roman', Times, serif;
  color: black;
  text-shadow: -1px -1px 0 #e6c2bf, 1px -1px 0 #e6c2bf, -1px 1px 0 #e6c2bf, 1px 1px 0 #e6c2bf;
  font-size: 51px;
}

.loginlink{
  margin-top: 20px;
}

.input {
  margin-bottom: 10px;
}

.form-control-confirm{
  margin-top: 10px;
   background-color: white;
  box-sizing: border-box;
  -webkit-appearance: none;
  width: 10%;
  border: solid #e6c2bf;
  font-family: inherit;
  padding: 0;
  height: 48px;
  font-size: 16px;
  font-weight: 500;
  border-radius: 0;
  transition: all .15s ease;
}

.form-control-confirm:hover{
  background-color: rgb(145, 175, 229);
}
</style>