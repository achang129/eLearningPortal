<template>
  <table id="all-courses-table-container">
    <caption> </caption>
    <thead>
      <tr>
        <th>Course</th>
        <th>Difficulty</th>
        <th>Cost</th>
        <th>Edit</th>
        <th>Delete</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="course in this.courses" v-bind:key="course.id">
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
    <br>
    <br>
    <router-link v-bind:to="{ name: 'create-course' }">Add Course</router-link>&nbsp;|&nbsp;
  </table>
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