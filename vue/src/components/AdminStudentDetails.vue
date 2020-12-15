<template>
  <div class="course">
    <div>
      <table class="student-table">
          <thead>
              <th>Student Name:</th>
              <th>Student Grade:</th>
          </thead>
          <tr v-for="student in students" v-bind:key="student.id">
              <td> {{ student.username }}</td>
              <td> {{ student.grade }}</td>
          </tr>
      </table>
    </div>
  </div>
</template>

<script>
// import gradeService from "../services/GradeService.js";



export default {
  components: { },
  name: "admin-student-details",
  data() {
    return {
      students: []
    }
  },
  computed: {},
  methods: {
//   getAllStudents(){
//       courseService.listStudents();
//   },

//   created() {
//     this.getAllStudents();
//   }
  }
};

</script>

<style>

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
  background-color:#7754af;
  opacity: 70%;
  border-radius: 2%;
  border-style:ridge;
  border-color: darkmagenta;
  width: 84%;
  font-family: "Trebuchet MS", Helvetica, sans-serif;
  font-size: 20px;
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
#add-teacher-student-click {
  color:mediumturquoise;
  font-size: 25px;
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