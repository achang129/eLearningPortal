<template>
    <div id="course-view-grid-container">
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
export default {
  name: 'course',
  components: {
    CourseInfo,
    UserSidebar
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