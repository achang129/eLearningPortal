<template>
  <div>
    <router-link v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"' 
      v-bind:to="{ name: 'create-course' }">Add Course</router-link>&nbsp;
    <div v-for="course in this.courses" v-bind:key="course.id" class="course-values">
       <h3 class="courseheaders">{{ course.name }} --- {{ course.classSize }} </h3>
       <p>{{course.description}}</p>
        
        
        <router-link class="main-link" :to="{ name: 'course', params: {id: course.id} }">View Details</router-link>
          
          
        <a href="#" v-on:click.prevent="deleteCourse(course.id)">Delete</a>
          
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
  name: "course-list",
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
    deleteCourse(id) {
      courseService.deleteCourse(id)
        .then(response => {
          if (response.status === 200) {
            this.courses = this.courses.filter((course)=>{return course.id !== id;});
          }
        }).catch(error => {
          if (error.response) {
            this.errorMsg = error.response.statusText;
          }
        });
    }
  },
  
  created() {
    this.makeCourseList();
  }
}
</script>

<style>
.courseheaders {
  margin-bottom: 0px;
}

.course-values router-link{
  display: block;
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  text-decoration: none; 
  z-index: 10; 
}

  /* #all-courses-table-container{
    
    
  } */
  #all-courses-table-caption{
    font-size: 30px;
  }
  .table-rows{
    font-size: 20px;
  }

  .course-values{
    text-align: center;
    position: relative;
    font-size: 20px;
    border: solid black;
    display: flex;
    flex-direction: column;
    margin-top: 10px;
    margin-right: 10px;
    margin-left: 10px;
    border-radius: 20px;
    background-color:#e6c2bf;
  }

  .course-values p{
    margin-left: 5px;
  }

  .course-values:nth-child(even){
    background-color: lightgreen;
  }
</style>