<template>
  <div>
    <button @click="$router.push({name: 'create-course'})" class="addcoursebutton" v-if='$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"' 
      >Add Course</button>&nbsp;
    <div v-for="course in this.courses" v-bind:key="course.id" class="course-values">
       <h3 class="courseheaders">{{ course.name }} <span id="course-id-value">(Course id: {{course.id}})</span></h3>
       <p id="course-description-summary">{{course.description}}</p>
        <!-- FOR THE TWO ROUTER LINKS: necessary to differentiate the functionality -- leave both in! -->
         <router-link v-if='$store.state.user.authorities[0]["name"]!="ROLE_ADMIN"' tag="div" class="main-link" 
         :to="{ name: 'course', params: {id: course.id} }"></router-link> 
         <router-link :to="{ name: 'course', params: {id: course.id} }">Course Details</router-link>
        <button class="deletecourse-btn" v-if='$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"' v-on:click.prevent="deleteCourse(course.id)">Delete</button> 
    </div>
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
.addcoursebutton {
	box-shadow: 3px 4px 0px 0px #8a2a21;
	background:linear-gradient(to bottom, #c62d1f 5%, #f24437 100%);
	background-color:#c62d1f;
	border-radius:18px;
	border:1px solid #d02718;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:17px;
	padding:7px 25px;
	text-decoration:none;
	text-shadow:0px 1px 0px #810e05;
}
.addcoursebutton:hover {
	background:linear-gradient(to bottom, #f24437 5%, #c62d1f 100%);
	background-color:#f24437;
}
.addcoursebutton:active {
	position:relative;
	top:1px;
}

.deletecourse-btn {
	box-shadow: 3px 4px 0px 0px #8a2a21;
	background:linear-gradient(to bottom, #c62d1f 5%, #f24437 100%);
	background-color:#c62d1f;
	border-radius:18px;
	border:1px solid #d02718;
	display:flex;
  justify-content: center;
  align-self: center;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:17px;
	padding:7px 25px;
	text-decoration:none;
	text-shadow:0px 1px 0px #810e05;
  width: 8%;
  margin-top: 10px;
  margin-bottom: 10px;
  
}
.deletecourse-btn:hover {
	background:linear-gradient(to bottom, #f24437 5%, #c62d1f 100%);
	background-color:#f24437;
}
.deletecourse-btn:active {
	position:relative;
	top:1px;
}

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
  #course-id-value{
    font-size: 13px;
    font-variant: small-caps;
    font-weight: 100;
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