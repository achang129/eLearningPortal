<template>
    <div id="select-teacher-course-grid">
        <div id="enrolled-teacher-roster">
            <p @click="this.toggleEnrolled()">Already Enrolled Teachers: </p>
            <ul v-for="enrolledTeacher in this.enrolledTeachers" v-bind:key="enrolledTeacher.id"
            v-show="showEnrolledTeachers" id="actual-enrolled-teacher-list" >
                <li class="enrolled-teacher-list">
                    {{enrolledTeacher.id}}--
                    {{enrolledTeacher.username}}
                    <button type="checkbox" v-bind:id="enrolledTeacher.id" v-bind:value="enrolledTeacher.id" 
                        v-on:change="removeUser($event)" class="removeIt">REMOVE</button>
                </li>
            </ul>
        </div>
        <table id="select-teacher-for-course">
            <caption id="box-choice-heading">Select Teacher for course</caption>
            <thead>
                <tr class="table-rows-teacher-list">
                    <th>SELECT</th>
                    <th>TEACHER ID</th>
                    <th>TEACHER NAME</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="teacher in this.teachers" v-bind:key="teacher.id">
                    <td>
                        <input type="checkbox" v-bind:id="teacher.id" v-bind:value="teacher.id" 
                        v-on:change="selectUser($event)" class="sendIt"/>
                    </td>
                    <td>{{teacher.id}}</td>
                    <td>{{teacher.username}}</td>
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
            selectedTeachers: [],
            enrolledTeachers: [],
            showEnrolledTeachers: true
        }
    },
    methods: {
        toggleEnrolled(){
            this.showEnrolledTeachers = !this.showEnrolledTeachers;
        },
        displayAllTeachers(){
            courseService.listUnchosenTeachers(this.id).then(response=>{
                response.data.forEach(teacher => {
                    this.teachers.push(teacher);
                    });
            });
            courseService.listEnrolledTeachers(this.id).then(response=> {
                response.data.forEach(theTeacher => {
                    this.enrolledTeachers.push(theTeacher);
                });
            });
        },
        selectUser(event) {
            if(event.target.checked) {
                this.selectedTeachers.push(event.target.id);
            } else {
                this.selectedTeachers = this.selectedTeachers.filter(teacher => {
                return teacher != event.target.id;
                });
            }
        },
        addSelected() {
            courseService.addTeacherToCourse(this.id, this.selectedTeachers);
            this.$forceUpdate();
        }
    },  
    mounted() {
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

#box-choice-heading{
    font-size:28px;
    font-variant-caps: all-petite-caps;
    font-weight: bolder;
}

#actual-enrolled-teacher-list{
    font-size: 15px;
    display: flex;
    flex-wrap: wrap;
}

#enrolled-teacher-list{
    font-size: 13px;
}

</style>