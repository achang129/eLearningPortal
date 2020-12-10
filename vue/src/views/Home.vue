<template>
  <div class="home">
    <header class="homeHeader">
      <img src="../assets/HomeGIF.gif" alt="Parthenon Home GIF">
    </header>
    <progress-bar class="progressbar"/>
    <user-sidebar v-if="$store.state.token != ''"/>
    <login-register-header v-if="$store.state.token == ''"/>
    
  </div>
</template>

<script>
import UserSidebar from '../components/UserSidebar.vue';
import LoginRegisterHeader from '../components/LoginRegisterHeader.vue';
import ProgressBar from '../components/ProgressBar.vue';
export default {
  components: { UserSidebar, LoginRegisterHeader, ProgressBar },
  name: "home"
,
    };
</script>

<style>


.progressbar{
  margin-top: 10px;
  grid-area: progressbar;
}

.homeHeader {
  grid-area: header;
  display: flex;
  justify-content: space-around;
 
}

.homeHeader img {
  border: solid black;
  border-color: #e6c2bf;
  border-radius: 24px;
  height: 17rem;
  width: 70%;
}

</style>