<template>
  <div id="register" class="text-center">
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
          class="form-control-reg"
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
          class="form-control-reg"
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
        <input class="radioBtn" type="radio" name="role" v-model="user.role" v-bind:value="'user'">
        <label for="user">Student</label>
        <input class="radioBtn" type="radio" name="role" v-model="user.role" v-bind:value="'teacher'">
        <label for="user">Instructor</label>
        <br>
        <br>
      </div>
      <button class="createAccButton" type="submit">
        Create Account
      </button>
      <div class="loginlink"><router-link :to="{ name: 'login' }">Already have an account? Login here</router-link></div>
    </form>
    <div class="register-gif">
        <img src="../assets/Login_RegisterGIF.gif" alt="Parthenon Logo Gif">
      </div>
  </div>
</template>

<script>
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
#register{
  background-image:url("../assets/background.png");
  
}

.createAccButton {
	box-shadow:inset 0px 1px 0px 0px #000000;
	background:linear-gradient(to bottom, #e6c2bf 5%, #ff6d63 100%);
	background-color:#e6c2bf;
	border-radius:6px;
	border:1px solid #0a000a;
	display:inline-block;
	cursor:pointer;
	color:#0a000a;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #ffffff;
}
.createAccButton:hover {
	
	background:linear-gradient(to bottom, #63a7ff 5%, #3accd1 100%);
	background-color:#ff6d63;
}

.createAccButton:active {
	position:relative;
	top:1px;
}

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

.form-control-reg {
   background-color: white;
  box-sizing: border-box;
  -webkit-appearance: none;
  width:auto;
  border: solid #e6c2bf;
  font-family: inherit;
  padding: 0;
  height: 48px;
  font-size: 16px;
  font-weight: 500;
  border-radius: 0;
  transition: all .15s ease;
}

.form-control-reg:hover{
  background-color: #bde3fc;
}

.form-control-confirm{
  margin-top: 10px;
   background-color: white;
  box-sizing: border-box;
  -webkit-appearance: none;
  width: auto;
  border: solid #e6c2bf;
  font-family: inherit;
  padding: 0;
  height: 48px;
  font-size: 16px;
  font-weight: 500;
  border-radius: 0;
  transition: all .15s ease;
}

.register-gif{
  display: inline-flex;
  align-content: center;
  justify-content: center;
  margin-top: 25px;
  width: fit-content;
  border: solid;
  border-color: #e6c2bf;
  grid-area: gif;
}

.form-control-confirm:hover{
  background-color: #bde3fc;
}
</style>