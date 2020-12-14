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
                        <input type="checkbox" v-bind:id="teacher.id" v-bind:value="teacher.id" 
                        v-on:change="selectUser($event)" class="sendIt"/>
                    </td>
                </tr>
            </tbody>
        </table>
        <button type="submit" v-on:submit.prevent v-on:click="addSelected()">Add Teacher</button>
    </div>
</template>

<script>
import courseService from '../services/CourseService'

export default {
    name: 'select-teacher',
    props: ["id"],
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
        selectUser(event) {
            if(event.target.checked) {
                this.selectedTeachers.push(event.target.id);
            }else {
                this.selectedTeachers = this.selectedTeachers.filter(teacher => {
                return teacher != event.target.id;
                });
            }
        },
        addSelected() {
            courseService.addTeacherToCourse(this.id, this.selectedTeachers);
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