<template>
  <div id="select-student-course-grid">
      <div id="enrolled-student-roster">
            <p @click="this.toggleEnrolled()">Already Enrolled Students: </p>
            <ul v-for="enrolledStudent in enrolledStudents" v-bind:key="enrolledStudent.id"
            v-show="showEnrolledStudents" id="actual-enrolled-student-list">
                <li class="enrolled-student-list">{{enrolledStudent.id}}--{{enrolledStudent.username}}</li>
            </ul>
        </div>
      <table id="select-student-for-course">
      <caption id="box-choice-heading">Select Student for Course</caption>
          <thead>
            <tr>
                <th>SELECT</th>
                <th>STUDENT ID</th>
                <th>STUDENT NAME</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="student in students" 
                v-bind:key="student.id">
                    <td>
                        <input type="checkbox" v-bind:id="student.id" v-bind:value="student.id" 
                        v-on:change="selectUser($event)" class="sendIt"/>
                    </td>
                    <td>{{student.id}}</td>
                    <td>{{student.username}}</td>
            </tr>
          </tbody>
      </table>
      <button type="submit" v-on:submit.prevent v-on:click="addSelected()">Add Student</button>
  </div>
</template>

<script>
import courseService from '../services/CourseService';

export default {
    name: 'student-list',
    props: ["id"],
    components: {},
    data() {
        return {
            students: [],
            selectedStudents: [],
            enrolledStudents: [],
            showEnrolledStudents: true
        }
    },
    methods: {
        toggleEnrolled(){
            this.showEnrolledStudents = !this.showEnrolledStudents;
        },
        displayAllStudents() {
            courseService.listUnchosenStudents(this.id).then(response => {
                response.data.forEach(student => {
                    this.students.push(student);
                });
            });
            courseService.listEnrolledStudents(this.id).then(response=> {
                response.data.forEach(theStudent => {
                    this.enrolledStudents.push(theStudent);
                });
            });
        },
        selectUser(event) {
            if(event.target.checked) {
                this.selectedStudents.push(event.target.id);
            } else {
                this.selectedStudents = this.selectedStudents.filter(student => {
                return student != event.target.id;
                });
            }
        },
        addSelected() {
            courseService.addStudentsToCourse(this.id, this.selectedStudents);
            this.$forceUpdate();
        }    
    },
    mounted() {
        this.displayAllStudents();
    }
}
</script>

<style>
#select-student-course-grid{
  background-color:#cc7979;
  opacity: 70%;
  border-radius: 2%;
  border-style:ridge;
  border-color: rgb(156, 100, 122);
  width: 84%;
  font-family: "Trebuchet MS", Helvetica, sans-serif;
  font-size: 20px;
  letter-spacing: 0px;
  word-spacing: 0px;
  color: #000000;
  font-weight: 700;
  font-style: normal;
}
#box-choice-heading{
    font-size:28px;
    font-variant-caps: all-petite-caps;
    font-weight: bolder;
}
#actual-enrolled-student-list{
    font-size: 15px;
    display: flex;
    flex-wrap: wrap;
}
#enrolled-student-list{
    font-size: 13px;
}


</style>