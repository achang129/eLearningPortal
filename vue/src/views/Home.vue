<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div class="home" id="home-view-grid-container" v-else>
      <header class="homeHeader">
        <img src="../assets/HomeGIF.gif" alt="Parthenon Home GIF">
      </header>
      <progress-bar class="progressbar" id="progress-bar"/>
      <user-sidebar id="home-user-sidebar" v-if="$store.state.token != ''"/>
      <login-register-header v-if="$store.state.token == ''"/>
      <div id="work-in-progress-todo" >
        <work-in-progress-notes v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"'/>
      </div>
    </div>
</template>

<script>
import UserSidebar from '../components/UserSidebar.vue';
import LoginRegisterHeader from '../components/LoginRegisterHeader.vue';
import ProgressBar from '../components/ProgressBar.vue';
import LoadingScreen from '../components/LoadingScreen.vue';
import WorkInProgressNotes from '../components/WorkInProgressNotes.vue';
export default {
  components: { UserSidebar, LoginRegisterHeader, 
    WorkInProgressNotes, ProgressBar, LoadingScreen },
  name: "home",
  data() {
    return {
        isLoading: true
      }
    },
    mounted () {
      setTimeout(() => {
      this.isLoading = false
    }, 1000)
    }
    };
</script>

<style>
#home-view-grid-container {
  display: grid;
  grid-template-columns: .75fr 4fr;
  grid-template-areas: 
  "progressbar header"
  "sidebar todo";
}
#home-user-sidebar {
  grid-area: sidebar;
}
#work-in-progress-todo {
  grid-area: todo;
}

.progressbar{
  margin-top: 10px;
  grid-area: progressbar;
  display: inline-block;
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
  height: 16rem;
  width: 90%;
}

</style>