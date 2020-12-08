<template>
  <div class="create-homework">
    <form v-on:submit.prevent>
      <div class="field">
        <label for="title">Title</label>
        <input type="text" name="title" v-model="homework.title" />
      </div>
      <div class="actions">
        <button type="submit" v-on:click="saveHomework()">Save</button>
      </div>
    </form>
  </div>
</template>

<script>
import homeworkService from "../services/HomeworkService";

export default {
  name: "create-homework",
  props: ["courseId"],
  data() {
    return {
      homework: {
        id: Math.floor(Math.random() * (1000 - 100) + 100),
        courseId: this.courseId,
        title: ""
      },
      errorMsg: ""
    };
  },
  methods: {
    saveHomework() {
      homeworkService.addHomework(this.homework)
        .then(response => {
          if (response.status === 200) {
            this.homework = {
                id: Math.floor(Math.random() * (1000 - 100) + 100),
                courseId: this.courseId,
                title: ""
            }
            this.$router.push('/homework')
          }
        }).catch(error => {
          this.errorMsg = error.response.statusText;
        });
    }
  }
};
</script>