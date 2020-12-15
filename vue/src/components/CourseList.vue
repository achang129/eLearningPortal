<template>
  <div>
    <router-link v-if='$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"' 
      v-bind:to="{ name: 'create-course' }">Add Course</router-link>&nbsp;
    <div v-for="course in this.courses" v-bind:key="course.id" class="course-values">
       <h3 class="courseheaders">{{ course.name }} --- {{ }} </h3>
       <p id="course-description-summary">{{course.description}}</p>
        <router-link tag="div" class="main-link" :to="{ name: 'course', params: {id: course.id} }"></router-link>
        <!-- <a href="#" v-on:click.prevent="deleteCourse(course.id)">Delete</a> -->
        <button v-if='$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"' v-on:click.prevent="deleteCourse(course.id)">Delete</button>
          
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
    },
    // USE BELOW TO ASSIGN TEACHER NAME TO COURSE CARD/QUICKLINK CARDS
    // getTeacher(id) {
    //   courseService.listAssignedTeachers(id)
    //     .then(response => {
    //       return response.data;
    //     });
    // }
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

.main-link:hover {
  cursor: pointer;
}

.main-link::before{
    content: " ";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

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
  }

  .course-values p{
    margin-left: 5px;
  }
  #course-description-summary {
    font-style: italic;
    font-size: 18px;
    font-variant-caps: unicase;
  }

  .course-values:nth-child(even){
    background-color: rgb(83, 189, 83);
    opacity: 80%;
  }
</style>