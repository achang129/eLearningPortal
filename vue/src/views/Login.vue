<template>
    <div id="login" class="text-center">
      <!-- <login-register-header /> -->
      <form class="form-signin" @submit.prevent="login">
        <h1 class="signintext">PARTHENON</h1>
        <div
          class="alert alert-danger"
          role="alert"
          v-if="invalidCredentials"
        >Invalid username and password!</div>
        <div
          class="alert alert-success"
          role="alert"
          v-if="this.$route.query.registration"
        >Thank you for registering, please sign in.</div>
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
        </div>
        <button class="submitbutton" type="submit">Sign in</button>
        <div class="needacc-link"><router-link :to="{ name: 'register' }">Need an account? Register here</router-link></div>
      </form>
      <div class="login-register-gif">
        <img src="../assets/Login_RegisterGIF.gif" alt="Parthenon Logo Gif">
      </div>
    </div>
</template> 

<script>
// import LoginRegisterHeader from '../components/LoginRegisterHeader.vue';
import authService from "../services/AuthService";

export default {
  name: "login",
  components: {},
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      invalidCredentials: false
    };
  },
  methods: {
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            this.$router.push("/");
          }
        })
        .catch(error => {
          const response = error.response;

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    }
  }
};
</script>

<style>
/* form {
 border: solid 3px rgb(155, 180, 202);
} */

.submitbutton:hover{
  background-color: rgb(145, 209, 229);
}

.text-center {
  text-align: center;
}

.form-control:hover{
  background-color: rgb(145, 175, 229);
}

.form-control {
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

.signintext{
  font-family: Georgia, 'Times New Roman', Times, serif;
  color: black;
  text-shadow: -1px -1px 0 #e6c2bf, 1px -1px 0 #e6c2bf, -1px 1px 0 #e6c2bf, 1px 1px 0 #e6c2bf;
  font-size: 70px;
}

.needacc-link{
  margin-top: 20px;
}


.login-register-gif{
  margin-top: 25px;
  width: fit-content;
  display: inline-flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border: solid;
  border-color: #e6c2bf;;
}




</style>