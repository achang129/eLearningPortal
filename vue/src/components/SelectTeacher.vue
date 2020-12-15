<template>
    <div id="select-teacher-course-grid">
        <table id="select-teacher-for-course">
            <caption id="box-choice-heading">Select Teacher for course</caption>
            <thead>
                <tr class="table-rows-teacher-list">
                    <th id="teacher-select-column-head">Teacher</th>
                    <th id="assign-column-head">Assign</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="teacher in this.teachers" v-bind:key="teacher.id">
                    <td>{{teacher.name}}</td>
                    <td><button :disabled='teacher.id==assigned' v-on:click.prevent='assignTeacher(teacher.id)'>Assign</button></td>
                </tr>
            </tbody>
        </table>
        <button type="submit" v-on:submit.prevent v-on:click="commit()">Save Changes</button>
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
            assigned: 0
        }
    },
    methods: {
        displayAllTeachers(){
            courseService.listTeachers(this.id).then(response=>{
                this.teachers = response.data
            });
            courseService.listAssignedTeachers(this.id).then(response=> {
                if(response.data.length > 0){
                    this.assigned = response.data[0].id;
                }else{
                    this.assigned = 0;
                }
            });
        },
        assignTeacher(id) {
            this.assigned = id;
        },
        commit(){
            courseService.assignToCourse(this.id, [this.assigned]);
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