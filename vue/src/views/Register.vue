<template>
  <div id="register">
    <div id="register-gif">
        <img src="../assets/newLogin_RegGIF.gif" alt="Parthenon Logo Gif">
    </div>
    <form id="form-register" @submit.prevent="register">
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
  display: grid;
  grid-template-columns: 1fr .5fr;
  grid-template-areas: 
  "gif form";
}
#form-register{
  grid-area: "form";
  text-align: center;
}
#register-gif{
  grid-area: "gif";
}

.createAccButton {
	box-shadow:inset 0px 1px 0px 0px #000000;
	background-color: #3a3535;
	border-radius:6px;
	border:1px solid #0a000a;
	display:inline-block;
	cursor:pointer;
	color: rgb(67, 136, 141);
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:6px 24px;
	text-decoration:none;
}
.createAccButton:hover {
	
	background:linear-gradient(to bottom, #63a7ff 5%, #3accd1 100%);
}

.createAccButton:active {
	position:relative;
	top:1px;
}

.registertext{
  font-family: Georgia, 'Times New Roman', Times, serif;
  color: rgb(67, 136, 141);
  text-shadow: -1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black, 1px 1px 0 black;
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
  border: solid  rgb(67, 136, 141);
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
  border: solid rgb(67, 136, 141);
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
  border-color:  rgb(67, 136, 141);
  grid-area: gif;
}

.form-control-confirm:hover{
  background-color: #bde3fc;
}
</style>