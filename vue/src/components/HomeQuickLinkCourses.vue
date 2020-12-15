<template>
  <div class="qlbox"> 
    <div class="welcomemessage">Welcome, {{ $store.state.user.username }}</div>
    <div v-for="course in this.courses" v-bind:key="course.id" class="quick-links">
       <h3 class="qlheads">{{ course.name }} --- {{  }}</h3>
        <router-link tag="div" class="mainlink" :to="{ name: 'course', params: {id: course.id} }">View Details</router-link>
    </div>
    <br>
    <br>
    <br>
    <br>
  </div>
</template>

<script>
import courseService from "@/services/CourseService.js";

export default {
  name: "quick-links",
  data() {
    return {
      errorMsg: "",
      courses: []
    }
  },
//   computed: {
//       getTeacher() {
          
//       }
//   },

  methods: {
    makeCourseList() {
      courseService.list().then(response => {
        response.data.forEach((course)=>{this.courses.push(course);});
      });
    },
  },
  
  created() {
    this.makeCourseList();
  }
}
</script>

<style>
.welcomemessage{
    display: flex;
    width: 100%;
}

.qlbox {
    display: flex;
    flex-flow: row wrap;
    width: 100%;
    height: 100%;
    border: solid gold;
    justify-content: start;
    
}

.qlheads {
  margin-bottom: 0px;
  text-align: center;
}

/* .mainlink::before{
    content: " ";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
} */

  #all-courses-table-caption{
    font-size: 30px;
  }
  .table-rows{
    font-size: 20px;
  }

  .quick-links{
    border: solid gold;
    text-align: center;
    font-size: 20px;
    font-variant-caps: petite-caps;
    border: solid black;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    margin-top: 10px;
    margin-right: auto;
    margin-left: auto;
    border-radius: 20px;
    background-color:#d69089;
    opacity: 80%;
    width: 10em;
    height: 10em;
  }

  .quick-links:nth-child(even){
    background-color: rgb(83, 189, 83);
    opacity: 80%;
  }
</style>