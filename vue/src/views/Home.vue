<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div class="home" id="home-view-grid-container" v-else>
      <header class="fb-item homeHeader">
        <img src="../assets/HomeGIF.gif" alt="Parthenon Home GIF">
      </header>
      <progress-bar v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_USER"' class="fb-item progressbar" id="progress-bar"/>
      <user-sidebar class="fb-item sidebar" id="home-user-sidebar" v-if="$store.state.token != ''"/>
      <div class="quicklinks-home">
       <home-quick-link-courses/>
      </div>
    </div>
</template>

<script>
import UserSidebar from '../components/UserSidebar.vue';
import ProgressBar from '../components/ProgressBar.vue';
import LoadingScreen from '../components/LoadingScreen.vue';
import HomeQuickLinkCourses from '../components/HomeQuickLinkCourses.vue';

export default {
  components: { UserSidebar, 
     ProgressBar, LoadingScreen, HomeQuickLinkCourses
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
#home-view-grid-container {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
  grid-template-areas: 
  ". header header header ."
  "sidebar quicklinks quicklinks quicklinks progressbar";
}
/* .home{
  display: flex;
  flex-direction: column;
  align-items: center;
  flex-wrap: wrap;
  justify-content: space-between;
  
} */
.quicklinks-home{
  display: flex;
  flex-flow: row wrap;
  flex-grow: 1;
  margin: auto;
  justify-content: space-around;
  font-size: 20px;
  font-variant-caps: petite-caps;
  width: 100%;
  height: 100%;
  border-radius: 20px;
  grid-area: quicklinks;
}

/* .fb-item {

} */

#home-user-sidebar {
  grid-area: sidebar;
  display: flex;
  align-self:flex-start;
  justify-content: flex-start;
  
}
#work-in-progress-todo {
  grid-area: todo;
  
}

.progressbar{
  margin-top: 10px;
  justify-content: space-between;
  display: flex;
  grid-area: progressbar;
  width: fit-content;
}

.homeHeader {
  grid-area: header;
  display: flex;
  align-self: center;
  justify-content: space-around;
  
 
}

.homeHeader img {
  border: solid #e6c2bf;
  border-radius: 24px;
  height: 16rem;
  width: 100%;

}

</style>