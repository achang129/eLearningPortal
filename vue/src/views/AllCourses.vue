<template>
  <div id="all-courses-view-page">
    <div class="all-courses">
      <header class="currHeader">
        <img src="../assets/coursesBanner.png" alt="Courses Banner" class="banner">
      </header>
      
    </div>
    <div id="all-courses-page-sidebar">
      <user-sidebar/>
    </div>
  </div>
</template>

<script>

import UserSidebar from '../components/UserSidebar.vue';
import CourseList from '../components/CourseList.vue';

export default {
  name: "all-courses",
  components: { UserSidebar, CourseList }
};

</script>

<style>

.all-courses {
  grid-area: allcourses;
}
#all-courses-page-sidebar {
  grid-area: sidebar;
}

#all-courses-view-page {
  display: grid;
  grid-template-columns: 1fr 4fr;
  grid-template-areas: "sidebar allcourses"
}

.currHeader {
  display: flex;
  justify-content: space-around;
}

.currHeader img {
  border: solid rgb(155, 180, 202);
  border-radius: 24px;
  height: 17rem;
  width: 69%;
  
}

.curricula {
  background-color: #05AED8;
  
}

.course-list {
  margin: 0 auto;
  max-width: 800px;
}
.course {
  font-size: 24px;
  border-bottom: 1px solid #f2f2f2;
  padding: 10px 20px;
}
.course:last-child {
  border: 0px;
}
table {
  text-align: left;
  width: 800px;
  border-collapse: collapse;
}
td {
  padding: 4px;
}
tbody tr:nth-child(even) {
  background-color: #f2f2f2;
}

.course-list a:link,
.course-list a:visited {
  color: blue;
  text-decoration: none;
}
.course-list a:hover {
  text-decoration: underline;
}
</style>