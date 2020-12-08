<template>
  <form v-on:submit.prevent>
    <div class="field">
      <label for="title">Title</label>
      <input type="text" v-model="course.name" />
    </div>
    <div class="actions">
      <button type="submit" v-on:click="saveCourse()">Save</button>
    </div>
  </form>
</template>

<script>
import courseService from "../services/CourseService";

export default {
  name: "create-course",
  data() {
    return {
      course: {
        id: Math.floor(Math.random() * (1000 - 100) + 100),
        name: ""
      },
      errorMsg: ""
    };
  },
  methods: {
    saveCourse() {
      CourseService.addCourse(this.course)
        .then(response => {
          if (response.status === 201) {
            courseService.list().then(response => {
              this.$store.commit("SET_COURSES", response.data);
            });
            this.course = {
              d: Math.floor(Math.random() * (1000 - 100) + 100),
              name: ""
            }
            this.$router.push('/');
          }
        }).catch(error => {
          this.errorMsg = error.response.statusText;
        });
    }
  }
};
</script>