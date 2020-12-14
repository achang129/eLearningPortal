<template>
  <div id="select-student-course-grid">
      <table id="select-student-for-course">
      <caption id="box-choice-heading">Select Student for Course</caption>
          <thead>
            <tr>
                <th>Student</th>
                <th>Assign</th>
                <th>Remove</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(student,index) in students" 
                v-bind:key="student.id">
                    <td>{{student.name}}</td>
                    <td>
                        <button :disabled='student.enrolled' v-on:click.prevent='addStudent(index)'>Add</button>
                    </td>
                    <td>
                        <button :disabled='!student.enrolled' v-on:click.prevent='removeStudent(index)'>Remove</button>
                    </td>
            </tr>
          </tbody>
      </table>
      <button type="submit" v-on:submit.prevent v-on:click="commit()">Save Changes</button>
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
            added: [],
            removed: []
        }
    },
    methods: {
        displayAllStudents() {
            let raw = [];
            courseService.listStudents(this.id).then(response => {
                 raw = response.data;
            });
            courseService.listAssignedStudents(this.id).then(response =>{
                this.students = raw.map((student)=>{
                    let en = false;
                    response.data.forEach((s)=>{
                        if(s.id==student.id){en=true;}
                    });
                    return {
                        'name': student.name,
                        'id': student.id,
                        'enrolled': en
                    };
                });
            });
        },
        addStudent(index) {
            let id = this.students[index].id;
            if(!this.added.includes(id)){this.added.push(id);}
            if(this.removed.includes(id)){this.removed.splice(index,1);}
            this.students[index].enrolled = true;
        },
        removeStudent(index) {
            let id = this.students[index].id;
            if(!this.removed.includes(id)){this.removed.push(id);}
            if(this.added.includes(id)){this.added.splice(index,1);}
            this.students[index].enrolled = false;
        },
        commit(){
            courseService.assignToCourse(this.id, this.added);
            courseService.removeFromCourse(this.id, this.removed);
            this.added = [];
            this.removed = [];
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