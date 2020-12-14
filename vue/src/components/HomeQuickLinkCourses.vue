<template>
  <div class="qlbox"> Welcome, {link student/teacher name here}
    <div v-for="course in this.courses" v-bind:key="course.id" class="quick-links">
       <h3 class="qlheads">{{ course.name }}</h3>
       
        <router-link class="main-link" :to="{ name: 'course', params: {id: course.id} }">View Details</router-link>
        
          
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
.qlbox {
    width: auto;
    height: auto;
    border: solid gold;
}

.qlheads {
  margin-bottom: 0px;
  text-align: center;
}

.main-link::before{
  display: block;
  position: absolute;
  width: 100%;
  height: 900%;
  top: 0;
  left: 0;
  text-decoration: none; 
}

  /* #all-courses-table-container{
    
    
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
    position: relative;
    font-size: 20px;
    font-variant-caps: petite-caps;
    border: solid black;
    display: flex;
    flex-direction: column;
    margin-top: 10px;
    margin-right: 10px;
    margin-left: 10px;
    border-radius: 20px;
    background-color:#d69089;
    opacity: 80%;
    width: 10em;
    height: 10em;
  }

  .quick-links p{
    margin-left: 5px;
  }
  #course-description-summary {
    font-style: italic;
    font-size: 18px;
    font-variant-caps: unicase;
  }

  .quick-links:nth-child(even){
    background-color: rgb(83, 189, 83);
    opacity: 80%;
  }
</style>