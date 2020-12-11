<template>
  <div class="course">
    <div id="course-details-heading">
      <div>Class: {{course.name}}</div>
      <div>Description: {{course.description}}</div>
      <div>Difficulty: {{course.difficulty}}</div>
      <div>Cost: {{course.cost}}</div>
    </div>
    <div id="teacher-select-section">
      <select-teacher v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"' />
    </div>
    <div class="daily">
      <div id="curricula-container">
        <table id="curriculum-table" style="width:100%">
          <caption class="tablecaption">Upcoming coursework</caption>
          <thead>
            <tr class="courseinforows">
              <th id="date-column">Date</th>
              <th id="lesson-column">Lesson Plan</th>
              <th id="homework-column">Homework</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="curriculum in this.curricula" v-bind:key="curriculum.date">
              <td class="curriculum-datum">{{curriculum.date}}</td>
              <td class="curriculum-datum">{{curriculum.lesson}}</td>
              <td class="curriculum-datum">TODO homework section</td>
            </tr>
          </tbody>
        </table>
        <br>
        <br>
        <br>
      </div>
      <form class="formtext" v-on:submit.prevent="addCurriculum">
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

export default {
  components: { SelectTeacher },
  name: "course",
  props: ["id"],
  data() {
    return {
      errorMsg: "",
      course: [],
      newLesson: "",
      newDate: new Date()
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
    getCoursework() {
      courseService.getCoursework(this.id).then(response => {
        this.course = response.data;
      });
    },
    addCurriculum() {
      console.log('test');
      courseService.addCurriculum(this.id,this.newLesson,this.newDate).then(response => { 
        if (response.status==201){
          this.newLesson= "";
          this.newDate= new Date();
          this.getCoursework();
        }
      })
    }
  },
  created() {
    this.getCoursework();
  }
};

</script>

<style>
.formtext{
  font-family: "Trebuchet MS", Helvetica, sans-serif;
}

.courseinforows{
  text-decoration: underline;
  font-family: "Trebuchet MS", Helvetica, sans-serif;
}

#course-details-heading{
  background-color:#e6c2bf;
  width: 84%;
  border: solid black;
  font-family: "Trebuchet MS", Helvetica, sans-serif;
  font-size: 40px;
  letter-spacing: 0px;
  word-spacing: 0px;
  color: #000000;
  font-weight: 700;
  font-style: normal;
  font-variant: small-caps;
  text-transform: capitalize;
  
}

.courseButton {
	background-color:#e6c2bf;
	border-radius:28px;
	border:1px solid #0d0c0c;
	display:inline-block;
	cursor:pointer;
	color:#000000;
	font-family:Arial;
	font-size:17px;
	padding:16px 31px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}
.courseButton:hover {
	background-color:#3accd1;
}
.courseButton:active {
	position:relative;
	top:1px;
}

.form-control-date {
  background-color: white;
  -webkit-appearance: none;
  width: 160px;
  border: solid #e6c2bf;
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
  border: solid #e6c2bf;
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
  width: 83%;
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
.course {
  font-size: 24px;
  border-bottom: 1px solid #f2f2f2;
  padding: 10px 20px;
}
.course:last-child {
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
tbody tr:nth-child(even) {
  background-color: #f2f2f2;
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
</style>