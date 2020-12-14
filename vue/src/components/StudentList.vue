<template>
  <div id="select-student-course-grid">
      <table id="select-student-for-course">
      <caption>Select Student for Course</caption>
          <thead>
            <tr>
                <th>STUDENT ID</th>
                <th>STUDENT NAME</th>
                <th>SELECT STUDENT</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="student in this.students" 
                v-bind:key="student.id">
                    <td>{{student.id}}</td>
                    <td>{{student.username}}</td>
                    <td>
                        <input type="checkbox" v-bind:id="student.id" v-bind:value="student.id" 
                        v-on:change="selectUser($event)" class="sendIt"/>
                    </td>
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
            selectedStudents: []
        }
    },
    methods: {
        displayAllStudents() {
            courseService.listStudents().then(response => {
                response.data.forEach(student => {
                    this.students.push(student);
                });
            });
        },
        selectUser(event) {
            if(event.target.checked) {
                this.selectedStudents.push(event.target.id);
            }else {
                this.selectedStudents = this.selectedStudents.filter(student => {
                return student != event.target.id;
                });
            }
        },
        addSelected() {
            courseService.addStudentsToCourse(this.id, this.selectedStudents);
        }    
    },
    created() {
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


</style>