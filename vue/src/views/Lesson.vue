<template>
  <div class="lesson-container">
      <router-link
          :to="{name: 'course', params: {id: this.courseid}}">
          <span>Go Back to Course Page</span>
        </router-link>
      <h1></h1>
      <div id="lesson">
        <p><span v-html="this.lesson"></span></p>
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



</style>