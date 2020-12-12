<template>
  <div>
    <router-link v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"' 
      v-bind:to="{ name: 'create-course' }">Add Course</router-link>&nbsp;
    <table id="all-courses-table-container">
      <caption id="all-courses-table-caption">Here are all your courses: <br><br><br></caption>
      <thead>
        <tr class="table-rows">
          <th>ID   &nbsp;  &nbsp;</th>
          <th>NAME &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</th>
          <th>CLASS LIMIT</th>
          <th>COST</th>
          <th>DETAILS</th>
          <th>DELETE</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="course in this.courses" v-bind:key="course.id" class="course-values">
          <td>{{ course.id }}</td>
          <td>{{ course.name }}</td>
          <td>{{ course.classSize }}</td>
          <td>{{ course.cost }}</td>
          <td>
            <router-link :to="{ name: 'course', params: {id: course.id} }">Course Details</router-link>
          </td>
          <td>
            <a href="#" v-on:click.prevent="deleteCourse(course.id)">Delete Course</a>
          </td>
        </tr>
      </tbody>
    </table>
    <br>
    <br>
    <br>
    <br>
  </div>
</template>

<script>
import courseService from "@/services/CourseService.js";

export default {
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
  #all-courses-table-caption{
    font-size: 30px;
  }
  .table-rows{
    font-size: 20px;
  }

  .course-values{
    font-size: 20px;
  }
</style>