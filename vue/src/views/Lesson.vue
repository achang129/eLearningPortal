<template>
<<<<<<< HEAD
  <div class="lesson-container">
      <router-link
=======
  <div id="lesson-grid-container" class="lesson">
      <router-link id="link-to-courses-in-lesson"
>>>>>>> 0528df225e5f41aacfc26600a05bbfe622d86d37
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
   <!-- <div class="lesson-sidebar">
     <user-sidebar />
   </div> -->
  </div>
</template>

<script>
// import UserSidebar from "../components/UserSidebar.vue"

export default{ 
  components: {  },
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
<<<<<<< HEAD
#lesson{
  width: 100%;
}

#lesson span{
  display: block;
  flex-direction: column;
  justify-content: center;
  border: solid black;
  background-color: #3a3535;
  color:rgb(175, 198, 216);
}



=======
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
>>>>>>> 0528df225e5f41aacfc26600a05bbfe622d86d37
</style>