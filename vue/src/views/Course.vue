<template>
    <div id="course-view-grid-container">
      <header class="courseHeader">
        <img src="../assets/courseDetailsBanner.png" alt="Course Details Banner">
      </header>
      <div class="course">
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