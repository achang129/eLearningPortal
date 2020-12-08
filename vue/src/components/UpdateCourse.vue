<template>
  <form v-on:submit.prevent>
    <div class="field">
      <label for="title">Title</label>
      <input type="text" v-model="name" />
    </div>
    <div class="actions">
      <button type="submit" v-on:click="updateCourse()">Save</button>
    </div>
  </form>
</template>

<script>
import courseService from "../services/CourseService";

export default {
  name: "update-course",
  props: ["courseId"],
  data() {
    return {
      name: "",
      errorMsg: ""
    };
  },
  methods: {
    updateCourse() {
      const course = { id: this.courseId, name: this.name };
      courseService.updateCourse(course)
        .then(response => {
          if (response.status === 200) {
            this.$router.push('/');
          }
        }).catch(error => {
          if (error.response) {
            this.errorMsg = error.response.statusText;
          }
        });
    }
  },
  created() {
    courseService
      .get(this.courseId)
      .then(response => {
        this.$store.commit("SET_ACTIVE_COURSE", response.data);
        this.name = response.data.name;
      })
      .catch(error => {
        if (error.response.status == 404) {
          this.$router.push("/not-found");
        }
      });
  }
};
</script>