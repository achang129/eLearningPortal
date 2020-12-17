<template>
  <div id="lesson-grid-container" class="lesson">
      <router-link id="link-to-courses-in-lesson"
          :to="{name: 'course', params: {id: this.courseid}}">
          <span>Go Back to Course Page</span>
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
}
#inner-lesson-view {
  grid-area: inner;
}
#link-to-courses-in-lesson{
  grid-area: linkback
}
#lesson-grid-container{
  grid-template-columns: .8fr 2fr 2fr 2fr .8fr;
  grid-template-areas: 
  ". linkback . . ."
  "outer inner inner inner outer"
   "outer inner inner inner outer"
    "outer inner inner inner outer"
     "outer inner inner inner outer"
      "outer inner inner inner outer"
}
</style>