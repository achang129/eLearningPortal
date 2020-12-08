<template>
  <div class="curricula">
    <table>
      <thead>
        <tr>
          <th>Course</th>
          <th>Edit</th>
          <th>Delete</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="course in this.$store.state.courses" v-bind:key="course.id">
          <td width="80%">
            <router-link
              v-bind:to="{ name: 'Homework', params: { id: course.id } }"
            >{{ course.title }}</router-link>
          </td>
          <td>
            <router-link :to="{ name: 'EditCourse', params: {id: topic.id} }">Edit</router-link>
          </td>
          <td>
            <a href="#" v-on:click="deleteCourse(course.id)">Delete</a>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import courseService from "@/services/CourseService.js";

export default {
  name: "curricula",
  data() {
    return {
      errorMsg: ""
    }
  },
  methods: {
    getCourses() {
      courseService.list().then(response => {
        this.$store.commit("SET_COURSES", response.data);
      });
    },
    deleteCourse(id) {
      courseService.deleteCourse(id)
        .then(response => {
          if (response.status === 200) {
            this.$store.commit('DELETE_COURSE', id);
            this.getCourses();
          }
        }).catch(error => {
          if (error.response) {
            this.errorMsg = error.response.statusText;
          }
        });
    }
  },
  
  created() {
    this.getCourses();
  }
};

</script>

<style>

</style>