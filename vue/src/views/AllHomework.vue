<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div class="homework-list" v-else>
      <header class="hw-header">
        <img src="../assets/assignmentsbanner.png" alt="Homework Banner">
      </header>
      <div class="all-homework">
        <course-homework />
      </div>
        <div id="all-homework-page-sidebar">
          <user-sidebar/>
      </div>
    </div>
</template>

<script>

import UserSidebar from '../components/UserSidebar.vue';
import CourseHomework from '../components/CourseHomework.vue';
import LoadingScreen from '../components/LoadingScreen.vue';

export default {
    name: "homework-list",
    components: { UserSidebar, CourseHomework, LoadingScreen },
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
}
</script>

<style>
.hw-header{
  display: flex;
  justify-content: space-around;
  grid-area: header;
}

.hw-header img{
  border: solid black;
  border-color: #e6c2bf;
  border-radius: 24px;
  height: 17rem;
  width: 70%;
}

.all-homework {
  grid-area: allhomework;
}
#all-homework-page-sidebar {
  grid-area: sidebar;
}

.homework-list {
  display: grid;
  grid-template-columns: 1fr 4fr;
  grid-template-areas: 
  "header header"
  "sidebar allhomework"
}
</style>