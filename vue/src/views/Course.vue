<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div id="course-view-grid-container" v-else>
      <div class="course">
        <div id="course-page-title">
          <h1>Course Details:</h1>
        </div>
        <course-info v-bind:id="$route.params.id" />
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
      setTimeout(() => {
      this.isLoading = false
    }, 1000)
    }
}
</script>

<style>
.course {
  grid-area: course;
}
#course-view-user-sidebar {
  grid-area: sidebar;
}

#course-view-grid-container {
  display: grid;
  grid-template-columns: 1fr 4fr;
  grid-template-areas: "sidebar course"
}

#course-page-title {
  justify-content: center;
  align-content: center;
  align-items: center;
  display:flex;
}



</style>