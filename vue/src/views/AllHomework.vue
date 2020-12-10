<template>
  <div class="homework-list">
    <div class="all-homework">
      <h1>Upcoming Assignments</h1>
      <course-homework />
    </div>
      <div id="all-homework-page-sidebar">
        <user-sidebar/>
    </div>
  </div>
</template>

<script>

import UserSidebar from '../components/UserSidebar.vue';
import CourseHomework from '../components/CourseHomework.vue'

export default {
  components: { UserSidebar, CourseHomework },
    name: "homework-list",
    component: {
        UserSidebar,
        CourseHomework
    }
}
</script>

<style>
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
  "sidebar allhomework"
}
</style>