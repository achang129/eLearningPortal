<template>
    <div id="select-teacher">
        <table id="select-teacher-for-course">
            <caption>Select Teacher for course</caption>
            <thead>
                <tr class="table-rows">
                    <th>USER ID</th>
                    <th>TEACHER NAME</th>
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

</style>