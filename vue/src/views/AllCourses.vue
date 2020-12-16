<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div id="all-courses-view-page" v-else>
      <header class="currHeader">
          <img src="../assets/coursesBanner.png" alt="Courses Banner" class="banner">
      </header>
      <div class="all-courses">
        <course-list/>
      </div>
      <div id="all-courses-page-sidebar">
        <user-sidebar/>
      </div>
    </div>
</template>

<script>

import UserSidebar from '../components/UserSidebar.vue';
import CourseList from '../components/CourseList.vue';
import LoadingScreen from '../components/LoadingScreen.vue';

export default {
  name: "all-courses",
  components: { UserSidebar, CourseList, LoadingScreen },
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

.all-courses {
  /* height: 92%;
  width: 81.1%;
  padding-left: 0px; */
  grid-area: allcourses;
  font-family: Georgia, 'Times New Roman', Times, serif;
  
  display: inline-block;
  
}
#all-courses-page-sidebar {
  grid-area: sidebar;
}

#all-courses-view-page {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
  grid-template-areas: 
  ". header header header ."
  "sidebar allcourses allcourses allcourses ."
}
.currHeader {
  display: flex;
  justify-content: center;
  width: 100%;
  grid-area: header;
}

.currHeader img {
  border: solid black;
  border-radius: 24px;
  height: 17rem;
  width: 100%;
}

.curricula {
  background-color: #33b3d3c7;
  
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