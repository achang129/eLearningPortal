<template>
    <div id="login">
      <header class="parthenonimg"> 
        <img src="../assets/loginname.png" alt="Parthenon Text" >
      </header>
      <!-- <h1 class="signintext">PARTHENON</h1>
      <h2 class="descriptiontext">Parthenon is an education organizational tool, designed to be your education center.
        
        <br>
        Our goal is to make organizing and staying on top of your education needs easier. For both students and faculty.
      </h2> -->
      <form class="form-signin" @submit.prevent="login">
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
        <button class="signinbtn" type="submit">Sign in</button>
        <div class="needacc-link"><router-link :to="{ name: 'register' }">Need an account? Register here</router-link></div>
      </form>
      <div class="login-register-gif">
        <img src="../assets/newLogin_RegGIF.gif" alt="Parthenon Logo Gif" class="gif">
      </div>
      <div class="description">
        <img src="../assets/logindescrip.png" alt="Description Login Text">
      </div>
    </div>
</template> 

<script>
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
.parthenonimg{
  display: flex;
  justify-content:space-evenly;
  grid-area: title;
  width: 100%;
  /* height: 34vh; */
}



#login{
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  grid-template-rows: .1fr 1fr .1fr;
  grid-template-areas: 
  "title title ."
  "gif gif login"
  "description description .";
}

.description{
 grid-area: description;
 display: flex;
 justify-content: space-evenly;
 margin-top: 20px;
}

.description img{
  width: 50vw;
}

/* .descriptiontext{
  border: solid black;
  font-size: 2em;
  width: 100vh;
  
  grid-area: description;
} */

.form-signin{
  width: fit-content;
  margin-top: 20px;
  margin-bottom: 0px;
  margin-left: 70px;
  grid-area: login;
}

.signinbtn {
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
.signinbtn:hover {
	background:linear-gradient(to bottom, #63a7ff 5%, #3accd1 100%);
	background-color:#ff6d63;
}
.signinbtn:active {
	position:relative;
	top:1px;
}



/* .text-center {
  text-align: center;
} */

.form-control:hover{
 background-color: #bde3fc;
}

.form-control {
  background-color: white;
  box-sizing: border-box;
  -webkit-appearance: none;
  width: 110%;
  border: solid #e6c2bf;
  font-family: inherit;
  padding: 0;
  height: 48px;
  font-size: 16px;
  font-weight: 500;
  border-radius: 0;
  transition: all .15s ease;
}

/* .signintext{
  font-family:'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
  color: black;
  text-shadow: -1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black, 1px 1px 0 black;
  font-size: 70px;
  grid-area: parthenontext;
} */

.needacc-link{
  margin-top: 20px;
}


.login-register-gif{
  /* margin-top: 25px;
  margin-left: 220px; */
  width: 100%;
  grid-area: gif;
  display: flex;
  justify-content: space-evenly;
}

.gif{
  height: 44vh;
  
}
</style>