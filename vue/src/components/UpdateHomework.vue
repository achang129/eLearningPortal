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
  props: ["courseid", "homeworkid"],
  data() {
    return {
      title: "",
      errorMsg: ""
    };
  },
  methods: {
    updateHomework() {
      const homework = {
        id: this.homeworkid,
        courseid: this.courseid,
        title: this.title
      };
      homeworkService.updateHomework(homework)
        .then(response => {
          if (response.status === 200) {
            this.$router.push(`/${homework.courseid}`);
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
      .get(this.homeworkid)
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