<template>
    <div id="select-teacher-course-grid">
        <table id="select-teacher-for-course">
            <caption>Select Teacher for course</caption>
            <thead>
                <tr class="table-rows-teacher-list">
                    <th>TEACHER ID</th>
                    <th>TEACHER NAME</th>
                    <th>SELECT TEACHER</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="teacher in this.teachers" v-bind:key="teacher.id">
                    <td>{{teacher.id}}</td>
                    <td>{{teacher.username}}</td>
                    <td>
                        <a href='#' 
                        @click.prevent="addTeacherToCourse(teacher.id)
                        ">Add teacher to course</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
import courseService from '../services/CourseService'

export default {
    name: 'select-teacher',
    components: {},
    data() {
        return {
            teachers: [],
            selectedTeachers: []
        }
    },
    methods: {
        displayAllTeachers(){
            courseService.listTeachers().then(response=>{
                response.data.forEach(teacher=>{
                    this.teachers.push(teacher);
                    });
            });
        },
        addTeacherToCourse() {
        }
    },
    created(){
        this.displayAllTeachers();
    }
}
</script>

<style>

#select-teacher-course-grid{
    background-color:#72aa7e;
  opacity: 70%;
  border-radius: 2%;
  border-style:ridge;
  border-color: rgb(26, 58, 39);
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