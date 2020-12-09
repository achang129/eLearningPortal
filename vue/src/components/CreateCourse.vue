<template>
  <form v-on:submit.prevent class="creation-form-general">
    <div class="field">
      <label for="title">Title</label>
        <input type="text"  
        v-model="course.name" @focus="course.name=''"/>
    </div>
    <div class="field">
      <label for="description">Description</label>
        <input type="text"
        v-model="course.description" @focus="course.description=''"/>
    </div>
    <div class="field">
      <label for="difficulty">Difficulty</label>
        <input type="text"  
        v-model="course.difficulty" @focus="course.difficulty=''"/>
    </div>
    <div class="field">
      <label for="cost">Cost</label>
        <input type="text"
        v-model="course.cost" @focus="course.cost=''"/>
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
        name: "" || "Enter the name of your course (up to 64 characters)",
        description: "" || "Brief description of the curriculum (256 characters)",
        difficulty: "" || "This helps people find the best course for their needs (12 characters)",
        cost: "" || "(US Dollars)"
      },
      errorMsg: ""
    };
  },
  methods: {
    saveCourse() {
      courseService.addCourse(this.course)
        .then(response => {
          if (response.status === 200) {
            this.$store.commit("SET_COURSES", this.course);
            this.course = {
              id: Math.floor(Math.random() * (1000 - 100) + 100),
              name: "",
              description: "",
              difficulty: "",
              cost: ""
            }
            this.$router.push('/course');
          }
        }).catch(error => {
          this.errorMsg = error.response.statusText;
        });
    }
  }
};
</script>

<style scoped>

form {
  padding: 20px;
  font-size: 16px;
}
form * {
  box-sizing: border-box;
  line-height: 1.5;
  color:midnightblue;
}
.field {
  display: flex;
  flex-direction: column;
}
.field label {
  margin: 4px 0;
  font-weight: bold;
}
.field input,
.field textarea {
  padding: 8px;
  font-size: 18px;
}
.field textarea {
  height: 300px;
}
.actions {
  text-align: right;
  padding: 10px 0;
}
</style>