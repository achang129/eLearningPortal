<template>
  <loading-screen v-if="isLoading" />
    <div id="course-view-grid-container" v-else>
      <header class="courseHeader">
        <img src="../assets/courseDetailsBanner.png" alt="Course Details Banner">
      </header>
      <div class="course">
        <course-info v-bind:courseid="$route.params.id" />
      </div>
      <div v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"'>
          <span id="add-assignment-header">Add Assignment</span>
          <create-homework v-bind:courseid="$route.params.id"/>
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
import CreateHomework from '../components/CreateHomework.vue'

export default {
  name: 'course',
  components: {
    CreateHomework,
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
  justify-content: space-around;
  grid-area: header;
}

.courseHeader img{
   border: solid black;
  border-color: #e6c2bf;
  border-radius: 24px;
  height: 17rem;
  width: 70%;
}

.course {
  grid-area: course;
}
#course-view-user-sidebar {
  grid-area: sidebar;
}

#course-view-grid-container {
  display: grid;
  grid-template-columns: .60fr 4fr;
  grid-template-areas: 
  "header header"
  "sidebar course";
}





</style>