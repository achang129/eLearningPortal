<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div v-else id="create-homework-object-view-page">
      <header class="hw-header">
        <img src="../assets/assignmentsbanner.png" alt="Homework Banner">
      </header>
      <div>
        <br><br><br>
        <create-homework id="create-homework-component-section" v-bind:course="this.$route.params.id" />
      </div>
      <div id="all-homework-page-sidebar">
        <user-sidebar/>
      </div>
    </div>
</template>

<script>
import CreateHomework from '../components/CreateHomework.vue';
import LoadingScreen from '../components/LoadingScreen.vue';
import UserSidebar from '../components/UserSidebar.vue';

export default {
  name: 'add-homework',
  components: {
    CreateHomework,
    LoadingScreen,
    UserSidebar
  },
  data() {
      return {
        isLoading: true
      }
    },
    mounted () {
      this.isLoading = false
    }
};
</script>
<style>
#create-homework-component-section {
  grid-area: "createhw"
}

#create-homework-object-view-page {
  display: grid;
  grid-template-columns: .75fr 4fr;
  grid-template-areas: 
  "header header"
  "sidebar createhw"
}
</style>