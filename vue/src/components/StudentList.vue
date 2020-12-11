<template>
  <div>
      <caption>Select Student for Course</caption>
      <table>
          <thead>
            <tr>
                <th>Select Student</th>
                <th>ID</th>
                <th>Student Name</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="student in this.students" 
                v-bind:key="student.id">
                    <td>
                        <input type="checkbox" v-bind:id="student.id" v-bind:value="student.id" 
                        v-on:change="selectUser($event)"/>
                    </td>
                    <td>{{student.id}}</td>
                    <td>{{student.username}}</td>
            </tr>
          </tbody>
      </table>
  </div>
</template>

<script>
import courseService from '../services/CourseService';

export default {
    name: 'student-list',
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
                this.selectedStudents.push(parseInt(event.target.id));
            }else {
                this.selectedStudents = this.selectedStudents.filter(student => {
                return student != parseInt(event.target.id);
                });
            }
        }    
    },
    created() {
        this.displayAllStudents();
    }
}
</script>

<style>

</style>