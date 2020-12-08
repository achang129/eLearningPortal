<template>
  <div class="course-homework">
    <h1>{{ this.$store.state.activeCourse.name }}</h1>
    <router-link
      :to="{ name: 'create-homework', params: {courseId: $store.state.activeCourse.id} }"
      class="AddHomework"
    >Add New Assignment</router-link>
    <div
      v-for="homework in this.$store.state.activeCourse.homework"
      v-bind:key="homework.id"
    >
      <h3 class="homework-title">{{ homework.title }}</h3>
      <p class="homework-body">{{ homework.info }}</p>
      <router-link
        :to="{name: 'EditHomework', params: {courseId: $store.state.activeCourse.id, homeworkId: homework.id} }"
        tag="button"
        class="btnEdit"
      >Edit</router-link>
      <button class="btnDelete" v-on:click="deleteHomework(homework.id)">Delete</button>
    </div>
  </div>
</template>

<script>
import courseService from "@/services/CourseService.js";
import homeworkService from "@/services/HomeworkService.js";

export default {
  name: "course-homework",
  data() {
    return {
      errorMsg: ""
    }
  },
  props: {
    courseId: Number
  },
  methods: {
    deleteHomework(id) {
      homeworkService.deleteHomework(id)
        .then(response => {
          if (response.status === 200) {
            this.$store.commit('DELETE_HOMEWORK', id);
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
      })
      .catch(error => {
        if (error.response.status == 404) {
          this.$router.push("/not-found");
        }
      });
  }
};
</script>
