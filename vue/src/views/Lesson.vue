<template>
  <div class="lesson-container">
    <header class="lesson-header">
      <img src="../assets/lessonsbanner.png" alt="">
    </header>
    <router-link
      :to="{name: 'course', params: {id: this.courseid}}">
      <span style="font-size: 15px"> ↰ Go Back to Course Page</span>
    </router-link>
    <h1></h1>
    <div id="lesson">
      <p id="inner-lesson-view">
        <span v-html="this.lesson"></span>
      </p>
    </div>
   <!-- <div class="lesson-sidebar">
     <user-sidebar />
   </div> -->
    <router-link class="bottom-back-to-course"
      :to="{name: 'course', params: {id: this.courseid}}">
      <span style="font-size: 15px"> ↰ Go Back to Course Page</span>
    </router-link>
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
.lesson-container{
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
  grid-template-areas: 
  ". header header header ."
  ". lesson lesson lesson ."
  "bottomlink . . . .";
}

#lesson{
  width: 100%;
  grid-area: lesson;
}

#lesson span{
  display: block;
  flex-direction: column;
  justify-content: center;
  background-color: #3a3535;
  color:rgb(175, 198, 216);
  margin: 2rem 5rem;
  padding: .5rem;
}

.lesson-header {
  display: flex;
  justify-content: center;
  width: 100%;
  grid-area: header;
}

.lesson-header img {
  border: solid black;
  border-radius: 24px;
  height: 17rem;
  width: 100%;
}

.bottom-back-to-course{
  grid-area: bottomlink;
  margin-left: 20px;
  margin-bottom: 20px;
}

</style>