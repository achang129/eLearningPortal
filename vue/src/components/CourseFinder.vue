<template>
    <div class='container'>
        <h1>Enroll in a new course!</h1>
        <table id='tblCourseSearch'>
            <caption>This table lets you search for a new course</caption>
            <thead>
                <tr>
                    <th id='tableTitle'>Search by Name or Course ID : </th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <label for='courseNameFilter'>Course Name : </label>
                    <input type='text' id='courseNameFilter' v-model='filter.courseName'/>
                    <button class='searchName' @click.prevent='getCourseByName'>Search name!</button>
                </tr>
                <tr>
                    <label for='courseIdFilter'>Course ID : </label>
                    <input type='text' id='courseIdFilter' v-model.number='filter.courseId'>
                    <button class='searchId' @click.prevent='getCourseById'> زرڭ</button>
                </tr>
            </tbody>
        </table>
        <button class='seeAllCourse' @click.prevent='getAllCourses'>See All Courses! </button>
    </div>
</template>

<script>
import courseService from '@/services/CourseService.vue';
export default {
    name: 'course-finder',
    data() {
        return {
            filter: {
                courseName: '',
                courseId: ''
            },
            curricula: []
        }   
    },
    methods: {
        //Get All Courses
        getAllCourses() {  
            courseService.list().then(response => {
                this.curricula = response.data;
            });
        },
        getCourseById() {
            alert("stop clicking");
            //TODO : course service method
        },
        getCourseByName() {
            //TODO : course service method
        }
    } 
}  
</script>

<style>

</style>