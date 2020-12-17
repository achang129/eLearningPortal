<template>
  <div id="lesson-grid-container" class="lesson">
      <router-link id="link-to-courses-in-lesson"
          :to="{name: 'course', params: {id: this.courseid}}">
          <span style="font-size: 25px"> ↰ Go Back to Course Page</span>
        </router-link>
      <h1></h1>
      <div id="lesson">
      </div>
      <div>
        <p id="inner-lesson-view">
          <span v-html="this.lesson"></span>
        </p>
      </div>
  </div>
</template>

<script>
export default {
    name: "lesson",
    props: ["courselesson"],
    data() {
      return {
        lesson: this.$store.state.currentLesson,
        courseid: this.$route.params.id
      }
    }
}
</script>
<style>
#lesson {
  grid-area: outer;
  background-color: beige;
  margin-top: 3%;
  margin-left: 3%;
  margin-right: 3%;
}
#inner-lesson-view {
  grid-area: inner;
  margin-left: 7%;
  margin-right: 7%;
  margin-bottom: 5%;
  margin-top: 5%;
}
#link-to-courses-in-lesson{
  grid-area: linkback;
}
</style>