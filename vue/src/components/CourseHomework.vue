<template>
  <div class="course-homework">
    <h1>{{ this.$store.state.activeCourse.name }}</h1>
    <div
      v-for="homework in this.$store.state.activeCourse.homework"
      v-bind:key="homework.id"
    >
      <h2 class="homework-title">{{ homework.title }}</h2>
      <p class="homework-body">{{ homework.info }}</p>
      <router-link v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"'
        :to="{name: 'EditHomework', params: {courseid: this.props.courseid, homeworkid: homework.id} }"
        tag="button"
        class="btnEdit"
      >Edit</router-link>
      <button class="btnDelete" v-on:click="deleteHomework(homework.id)">Delete</button>
    </div>
    <div v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"'>
          <span id="add-assignment-header">Add Assignment</span>
          <create-homework v-bind:courseid="$route.params.id"/>
      </div>
  </div>
</template>

<script>
import homeworkService from "@/services/HomeworkService.js";

export default {
  name: "course-homework",
  props: ["courseid"],
  data() {
    return {
      errorMsg: ""
    }
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
    
  }
};
</script>
