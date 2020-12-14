<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div class="home" id="home-view-grid-container" v-else>
      <header class="fb-item homeHeader">
        <img src="../assets/HomeGIF.gif" alt="Parthenon Home GIF">
      </header>
      <progress-bar v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_USER"' class="fb-item progressbar" id="progress-bar"/>
      <user-sidebar class="fb-item sidebar" id="home-user-sidebar" v-if="$store.state.token != ''"/>
     <div class="quicklinks">
       <home-quick-link-courses/>
    </div>
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
import HomeQuickLinkCourses from '../components/HomeQuickLinkCourses.vue';

export default {
  components: { UserSidebar, LoginRegisterHeader, 
    WorkInProgressNotes, ProgressBar, LoadingScreen, HomeQuickLinkCourses
     },
  
    HomeQuickLinkCoursesame: "home",
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
/* #home-view-grid-container {
  display: grid;
  grid-template-columns: .75fr 4fr;
  grid-template-areas: 
  ". header ."
  "sidebar todo progressbar";
} */
.home{
  display: flex;
  flex-direction: column;
  align-items: center;
  flex-wrap: wrap;
  justify-content: space-between;
  
}
.quicklinks{
  display: flex;
  justify-self: center;
  align-self: center;
  text-align: center;
  align-self: center;
  position: relative;
  font-size: 20px;
  font-variant-caps: petite-caps;
  width: auto;
  height: auto;
  border-radius: 20px;
  order: 3;
    
}

/* .fb-item {

} */

#home-user-sidebar {
  grid-area: sidebar;
  order: 2;
  align-self:flex-start;
  justify-content: flex-start;
  
}
#work-in-progress-todo {
  grid-area: todo;
  order: 3;
}

.progressbar{
  margin-top: 10px;
  justify-content: space-between;
  display: inline-block;
  order: 2;
  align-self: flex-end;
}

.homeHeader {
  grid-area: header;
  display: flex;
  align-self: center;
  justify-content: space-around;
  order: 1;
 
}

.homeHeader img {
  border: solid #e6c2bf;
  border-radius: 24px;
  height: 16rem;
  width: 90%;
}

</style>