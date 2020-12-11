<template>
  <div >
      <table>
          <tr>
              <th>&nbsp;</th>
              <th>ID</th>
              <th>Student Name</th>
          </tr>
          <tr v-for="student in students" 
              v-bind:key="student.id">
                <td>
                    <input type="checkbox" v-bind:id="student.id" v-bind:value="student.id" 
                           v-on:change="selectStudent($event)">
                </td>
                <td>{{student.id}}</td>
                <td>{{student.username}}</td>
          </tr>
      </table>
  </div>
</template>

<script>
import courseService from '../services/CourseService';

export default {
    name: 'list-student',
    data() {
        return {
            students: [],
            selectedStudents: []
        }
    },
    methods: {
        displayAllStudents() {
            courseService.listTeachers().then(response => {
                response.data.forEach(teacher => {
                    this.teachers.push(teacher);
                });
            });
        },
        selectStudent(event) {
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