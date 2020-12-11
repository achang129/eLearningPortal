<template>
  <table id="all-courses-table-container">
    <caption> </caption>
    <thead>
      <tr class="table-rows">
        <th>ID</th>
        <th>COURSE Name</th>
        <th>DIFFICULTY</th>
        <th>COST</th>
        <th>EDIT</th>
        <th>DELETE</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="course in this.courses" v-bind:key="course.id" class="course-values">
        <td>{{ course.id }}</td>
        <td>{{ course.name }}</td>
        <td>{{ course.difficulty }}</td>
        <td>{{ course.cost }}</td>
        <td>
          <router-link :to="{ name: 'course', params: {id: course.id} }">View Details</router-link>
        </td>
        <td>
          <a href="#" v-on:click.prevent="deleteCourse(course.id)">Delete</a>
        </td>
      </tr>
    </tbody>
    <br>
    <br>
    <tr><student-list></student-list></tr>
    <br>
    <br>
    <router-link v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"' 
    v-bind:to="{ name: 'create-course' }">Add Course</router-link>&nbsp;
  </table>
</template>

<script>
import courseService from "@/services/CourseService.js";
import StudentList from './StudentList';

export default {
  components: {StudentList},
  name: "course-list",
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
    },
    deleteCourse(id) {
      courseService.deleteCourse(id)
        .then(response => {
          if (response.status === 200) {
            this.courses = this.courses.filter((course)=>{return course.id !== id;});
          }
        }).catch(error => {
          if (error.response) {
            this.errorMsg = error.response.statusText;
          }
        });
    }
  },
  
  created() {
    this.makeCourseList();
  }
}
</script>

<style>
  /* #all-courses-table-container{
    
    
  } */

  .table-rows{
    font-size: 20px;
  }

  .course-values{
    font-size: 23px;
  }
</style>