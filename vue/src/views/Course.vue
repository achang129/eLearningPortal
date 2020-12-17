<template>
  <loading-screen v-if="isLoading" />
    <div id="course-view-grid-container" v-else>
      <header class="courseHeader">
        <img src="../assets/coursedetails.png" alt="Course Details Banner">
      </header>
      <div class="course">
        <course-info v-bind:courseid="$route.params.id" />
      </div>
      <div id="course-view-user-sidebar">
        <user-sidebar/>
      </div>
    </div>
</template>

<script>

import CourseInfo from "../components/CourseInfo.vue"
import UserSidebar from "../components/UserSidebar.vue"
import LoadingScreen from '../components/LoadingScreen.vue'

export default {
  name: 'course',
  components: {
    CourseInfo,
    UserSidebar,
    LoadingScreen
  },
  data() {
      return {
        isLoading: true
      }
    },
    mounted () {
      this.isLoading = false
    }
}
</script>

<style>
.courseHeader{
  display: flex;
  justify-content: center;
  grid-area: header;
  width: 100%;
}

.courseHeader img{
   border: solid black;
  border-radius: 24px;
  height: 17rem;
  width: 100%;
}

.course {
  grid-area: course;
  display: flex;
  flex-direction: column;
  justify-self: center;
  width: 100%;
}
#course-view-user-sidebar {
  grid-area: sidebar;
}

#course-view-grid-container {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
  grid-template-areas: 
  ". header header header ."
  "sidebar course course course .";
}
</style>