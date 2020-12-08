<template>
  <form v-on:submit.prevent>
    <div class="field">
      <label for="title">Title</label>
      <input name="title" type="text" v-model="title" />
    </div>
    <div class="actions">
      <button type="submit" v-on:click="updateHomework()">Update</button>
    </div>
  </form>
</template>

<script>
import homeworkService from "../services/HomeworkService";

export default {
  name: "update-homework",
  props: ["courseId", "homeworkId"],
  data() {
    return {
      title: "",
      errorMsg: ""
    };
  },
  methods: {
    updateHomework() {
      const homework = {
        id: this.homeworkId,
        courseId: this.courseId,
        title: this.title
      };
      homeworkService.updateHomework(homework)
        .then(response => {
          if (response.status === 200) {
            this.$router.push(`/${homework.courseId}`);
          }
        }).catch(error => {
          if (error.response) {
            this.errorMsg = error.response.statusText;
          }
        });
    }
  },
  created() {
    homeworkService
      .get(this.homeworkId)
      .then(response => {
        this.$store.commit("SET_ACTIVE_HOMEWORK", response.data);
        this.title = response.data.title;
      })
      .catch(error => {
        if (error.response.status == 404) {
          this.$router.push("/not-found");
        }
      });
  }
};
</script>