<template>
 <div class="dash-container">
   <header class="dashboardheader">
     <img src="../assets/studentdashboard.png" alt="Student Dashboard Banner">
   </header>
  <div v-if='$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"' class="studentdeets">
   <div v-for="course in courses" v-bind:key="course.id" class="course-values">
       <h3 class="courseheaders">{{ course.name }} <span id="course-id-value">(Course id: {{course.id}})</span></h3>
       <p id="course-description-summary">{{course.description}}</p>
         <router-link class="main-link" :to="{ name: 'dashboard-by-class', params: {id: course.id} }">Course Details</router-link>
    </div>
  </div>
  <admin-student-details v-if='$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"' class="studentdeets" />
  <user-sidebar class="dash-sidebar"/>
 </div>
</template>

<script>
import AdminStudentDetails from '../components/AdminStudentDetails.vue'
import UserSidebar from '../components/UserSidebar.vue'
import courseService from '../services/CourseService.js'

export default {
  components: { AdminStudentDetails, UserSidebar },
   data() {
    return {
      errorMsg: "",
      courses: []
    }
  },
    methods: {
        makeCourseList() {
        courseService.list().then(response => {
            response.data.forEach((course)=>{this.courses.push(course);});
        });
        }
    },
    created() {
    this.makeCourseList();
  }
}
</script>

<style>
.dash-container {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
  grid-template-areas: 
  ". header header header ."
  "sidebar teachercourses teachercourses teachercourses .";
}



.dash-sidebar{
  grid-area: sidebar;
  display: flex;
  align-self:flex-start;
  justify-content: flex-start;
  
}

.studentdeets{
  display: inline-block;
  grid-area: teachercourses;
}

.dashboardheader{
   display: flex;
  justify-content: center;
  grid-area: header;
  width: 100%;
}

.dashboardheader img{
   border: solid black;
  border-color: #e6c2bf;
  border-radius: 24px;
  height: 17rem;
  width: 100%;
}
</style>