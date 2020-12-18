<template>
  <div class="course-comp">
    <div id="course-details-heading">
        <div>Course Id: {{courseid}}</div>
        <div>Class: {{course.name}}</div>
        <div>Description: {{course.description}}</div>
        <div>Class Limit: {{course.classSize}}</div>
        <div>Cost: {{course.cost}}</div>
    </div>
    <div id="user-select-section" v-if='$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"'>
        <div id="teacher-select-section">
            <button id="add-teacher-student-click" @click="toggleTeacher()">Click to add/view/remove teachers</button>
            <select-teacher v-bind:id=this.courseid v-show="this.showSectionTeacher"/>
        </div>
        <div id="student-select-section">
            <button id="add-teacher-student-click"  @click="toggleStudent()">Click to add/view/remove students</button>
            <student-list v-bind:id=this.courseid v-show="this.showSectionStudent"/>
        </div>
    </div>
    <div class="daily">
       <h2 class="tablecaption">Upcoming coursework<br/><br/>
          </h2>
      <div id="curricula-container">
        <table id="curriculum-table" style="width:100%">
          <thead>
              <tr class="courseinforows">
                  <th id="date-column">Date</th>
                  <th id="lesson-column">Lesson</th>
                  <th id="homework-column">Homework</th>
                  <th id="empty-column"></th>
              </tr>
          </thead>
          <tbody id="info-rows">
              <tr v-for="curriculum in this.curricula" v-bind:key="curriculum.date">
                  <td class="curriculum-datum">{{curriculum.date}}</td>
                  <td class="curriculum-datum">
                    <button id="lesson-hyper-link" @click.prevent="goToLesson(curriculum)" >
                    Click to View Lesson
                    </button>
                  </td>
                  <td class="curriculum-datum">
                    <div v-if='$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"'>
                      <button class="newassign-btn" v-if='!curriculum.homework' v-on:click.prevent="addHomework">
                        Add New Assignment</button>
                      <button v-else v-on:click.prevent="editHomework">
                        Edit assignment</button>
                      <button :disabled='!curriculum.homework' v-if='$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"' v-on:click.prevent="removeHomework(curriculum.homework)" style="display: block">
                        Remove Homework</button>
                    </div>
                      <button v-else id="homework-hyper-link" :disabled='!curriculum.homework' @click.prevent="goToAssignment(curriculum.homework)">
                      View Homework</button>
                  </td>
              </tr>
          </tbody>
        </table>
        <div id="empty-message" v-show="this.course.curricula.length==0">
        
          <p>Looks Like There are No Lessons So Far!</p>
          
        </div>
        <br>
      </div>
      <form class="formtext" v-on:submit.prevent="addCurriculum" v-if='$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"'>
        <label>Date: </label>
        <input type="date" v-model="newDate" class="form-control-date"/> |
        <label>Lesson Plan: </label>
        <input type="text" v-model="newLesson" class="form-control-lesson"/> |
        <label></label>
        <input type="submit" class="courseButton" />
      </form>
    </div>
  </div>
</template>

<script>
import courseService from "../services/CourseService.js";
import SelectTeacher from "./SelectTeacher.vue";
import StudentList from './StudentList';

export default {
  components: { SelectTeacher, StudentList},
  name: "course",
  props: ["courseid"],
  data() {
    return {
      errorMsg: "",
      course: {
        'name': "",
        'description': "",
        'cost': 0,
        'dates': [],
        'curricula': []
      },
      newLesson: "",
      newDate: new Date(),
      showSectionTeacher: false,
      showSectionStudent: false
    }
  },
  computed: {
    curricula: function(){
      let c = [];
      for(let i=0;i<this.course.dates.length;i++){
        c[i] = {date: this.course.dates[i],lesson: this.course.curricula[i].lesson};
      }
      return c;
    }
  },
  methods: {
    goToLesson(curriculum){
      this.setCurrentLesson(curriculum.lesson);
      this.$router.push({name: 'lesson', params: {id: this.$props.courseid}});
    },
    goToAssignment(assignment){
      alert(assignment);
    },
    removeHomework(assignment){
      alert(assignment)
    },
    setCurrentLesson(lesson){
      this.$store.commit('SET_CURRENT_LESSON', lesson);
    },
    toggleTeacher(){
      this.showSectionTeacher = !this.showSectionTeacher;
    }, 
    toggleStudent(){
      this.showSectionStudent = !this.showSectionStudent;
    },
    getCoursework() {
      courseService.getCoursework(this.courseid).then(response => {
        if(response.status==200){
          this.course = response.data;
        }
      });
    },
    addCurriculum() {
      courseService.addCurriculum(this.courseid,this.newLesson,this.newDate).then(response => { 
        if (response.status==201){
          this.newLesson= "";
          this.newDate= new Date();
          this.getCoursework();
        }
      })
    },
    addHomework() {
      this.$store.commit("SET_ACTIVE_COURSE",this.courseid);
      this.$router.push({ name: 'create-assignment', params: {courseid: this.$props.courseid} })
    }
  },
  created() {
    this.getCoursework();
  }
};

</script>

<style>
/* .daily{
  display: flex;
  flex-direction: column;
  align-self: center;
} */

.formtext{
  font-family: "Trebuchet MS", Helvetica, sans-serif;
}

.courseinforows{
  text-decoration: underline;
  font-family: "Trebuchet MS", Helvetica, sans-serif;
}

#empty-message{
  justify-items: center;
  justify-content: center;
  display: inline-flex;
  color: rgb(131, 43, 40);
  font-size: 30px;
}

#course-details-heading{
  background-color:#3a3535;
  opacity: 70%;
  border-radius: 2%;
  border-style:ridge;
  border-color: black;
  width: 97%;
  font-family: "Trebuchet MS", Helvetica, sans-serif;
  font-size: 20px;
  letter-spacing: 0px;
  word-spacing: 0px;
  color: rgb(175, 198, 216);
  font-weight: 700;
  font-style: normal;
  font-variant: small-caps;
  text-transform: capitalize;
  margin-top: 15px;
  margin-left: 10px;
  
}

.courseButton {
	background-color:rgb(38, 62, 82);
	border-radius:28px;
	border:1px solid #0d0c0c;
	display:inline-block;
	cursor:pointer;
	color:white;
	font-family:Arial;
	font-size:17px;
	padding:16px 31px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}
.courseButton:hover {
	background-color:#6685ad;
}
.courseButton:active {
	position:relative;
	top:1px;
}
#add-teacher-student-click {
  color:rgb(72, 131, 209);
  font-size: 25px;
}

#add-teacher-student-click:hover{
  cursor: pointer;
}

.form-control-date {
  background-color: white;
  -webkit-appearance: none;
  width: 160px;
  border: solid rgb(38, 62, 82);
  font-family: inherit;
  padding: 0;
  height: 48px;
  font-size: 16px;
  font-weight: 500;
  border-radius: 0;
  transition: all .15s ease;
}

.form-control-date:hover{
  background-color: #bde3fc;
}

.form-control-lesson:hover{
 background-color: #bde3fc;
}

.form-control-lesson{
   background-color: white;
  -webkit-appearance: none;
  width: 300px;
  border: solid rgb(38, 62, 82);
  font-family: inherit;
  padding: 0;
  height: 48px;
  font-size: 16px;
  font-weight: 500;
  border-radius: 0;
  transition: all .15s ease;
}
.tablecaption{
  margin-top: 5px;
  display: flex;
  justify-content: center;
  width: 100%;
  font-family: "Trebuchet MS", Helvetica, sans-serif;
  font-size: 40px;
  letter-spacing: 0px;
  word-spacing: 0px;
  color: #000000;
  font-weight: 700;
  text-decoration: underline;
  font-style: normal;
  font-variant: small-caps;
  text-transform: capitalize;
}
#curricula-container{
  display:flex;
  flex-direction: column;
  justify-content: center;
}
.course-list {
  margin: 0 auto;
  max-width: 800px;
}
.course-comp {
  display: flex;
  flex-direction: column;
  justify-content: center;
  /* font-size: 24px;
  border-bottom: 1px solid #f2f2f2;
  padding: 10px 20px; */
}
.course-comp:last-child {
  border: 0px;
}
table {
  text-align: left;
  width: 800px;
  border-collapse: collapse;
}
td {
  padding: 4px;
}

.newassign-btn:hover, #lesson-hyper-link:hover{
  cursor: pointer;
}

.course-list a:link,
.course-list a:visited {
  color: blue;
  text-decoration: none;
}
.course-list a:hover {
  text-decoration: underline;
}
.curriculum-datum {
  font-size: 15px;
}

#info-rows>tr{
  color: black;
}

#info-rows>tr:nth-child(even){
  color: rgb(175, 198, 216);
}
</style>