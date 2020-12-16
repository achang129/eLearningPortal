<template>
 <div>
  <div v-if='$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"' class="teacherstudentdeets">
   <div v-for="course in courses" v-bind:key="course.id" class="course-values">
       <h3 class="courseheaders">{{ course.name }} <span id="course-id-value">(Course id: {{course.id}})</span></h3>
       <p id="course-description-summary">{{course.description}}</p>
         <router-link class="main-link" :to="{ name: 'dashboard-by-class', params: {id: course.id} }">Course Details</router-link>
    </div>
    <user-sidebar/>
  </div>
  <admin-student-details v-if='$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"' />
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

</style>