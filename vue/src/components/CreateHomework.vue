<template>
  <div class="create-homework">
    <form id="create-homework-form">
      <div class="field">
        <label for="title">Title</label>
        <input type="text" name="title" v-model="homework.name" @focus.prevent="homework.name=''"/>
        <label for="due-date">Due Date</label>
        <input type="date" v-model="homework.dueDate"/>
        &nbsp; &nbsp; &nbsp; &nbsp;
        <button class="actions" type="submit" v-bind:course="this.$props.id" @click.prevent="saveHomework()">Save</button>
      </div>
    </form>
  </div>
</template>

<script>
import homeworkService from "../services/HomeworkService";

export default {
  name: "create-homework",
  props: ["id"],
  data() {
    return {
      homework: {
        name: "" || "Enter name of assignment",
        dueDate: "",
        course: this.$props.id
      },
      errorMsg: ""
    };
  },
  methods: {
    saveHomework() {
      alert(this.homework.course);
      homeworkService.addHomework(this.homework)
        .then(response => {
          if (response.status === 201) {
            this.$router.push({name: 'all-homework'});
          }
        }).catch(error => {
          this.errorMsg = error.response.statusText;
        });
    }
  },
  created() {
    this.$store.commit('BLANK_ASSIGNMENT');
  }
};
</script>
<style scoped>
#create-homework-form{
  font-size: 20px;
}
</style>