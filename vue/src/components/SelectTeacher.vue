<template>
    <div>
        <button style="display: block" id="add-teacher-student-click" @click="toggleTeacher()">Click to add/view/remove teachers</button>
        <div v-show="this.showSectionTeacher" id="select-teacher-course-grid">
            <table id="select-teacher-for-course">
                <caption id="box-choice-heading">Select Teacher for course</caption>
                <thead>
                    <tr class="add-teacher-row-heads">
                        <th>Teacher</th>
                        <th>Assign</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(teacher,index) in teachers" 
                    :key="teacher.id">
                        <td>{{teacher.name}} </td>
                        <td>
                            <button :disabled='teacher.enrolled' @click.prevent='addTeacher(index)'>Add</button>
                        </td>
                        <td>
                            <button :disabled='!teacher.enrolled' @click.prevent='removeTeacher(index)'>Remove</button>
                        </td>
                    </tr>
                </tbody>
            </table>
            <button type="submit" v-on:submit.prevent @click="commit()">Save Changes</button>
        </div>
    </div>
</template>

<script>
import courseService from '../services/CourseService'

export default {
    name: 'select-teacher',
    //id here is course id
    props: ["id"],
    components: {},
    data() {
        return {
            teachers: [],
            added: [],
            removed: [],
            showSectionTeacher: false
        }
    },
    methods: {
        displayAllTeachers(){
            let raw = [];
            courseService.listTeachers(this.id).then(response=>{
                raw = response.data;
            });
            courseService.listAssignedTeachers(this.id).then(response=> {
                this.teachers = raw.map(teacher=>{
                    let en = false;
                    response.data.forEach(t=>{
                        if(t.id==teacher.id){en=true;}
                    });
                    return {
                        'name': teacher.name,
                        'id': teacher.id,
                        'enrolled': en
                    };
                });
            });
        },
        toggleTeacher(){
            this.showSectionTeacher = !this.showSectionTeacher;
         }, 
        addTeacher(index) {
            let id = this.teachers[index].id;
            if(!this.added.includes(id)){this.added.push(id);}
            if(this.removed.includes(id)){this.removed.splice(index,1);}
            this.teachers[index].enrolled = true;
        },
        removeTeacher(index) {
            let id = this.teachers[index].id;
            if(!this.removed.includes(id)){this.removed.push(id);}
            if(this.added.includes(id)){this.added.splice(index,1);}
            this.teachers[index].enrolled = false;
        },
        commit(){
            this.showSectionTeacher = false;
            courseService.assignToCourse(this.id, this.added);
            courseService.removeFromCourse(this.id, this.removed);
            this.added = [];
            this.removed = [];
            this.$forceUpdate();
        }
    },  
    mounted() {
        this.displayAllTeachers();
    }
}
</script>

<style scoped>
#select-teacher-course-grid{
    /* background-color:#72aa7e; */
  opacity: 70%;
  /* border-radius: 2%;
  border-style:ridge;
  border-color: rgb(26, 58, 39); */
  width: 84%;
  font-family: "Trebuchet MS", Helvetica, sans-serif;
  font-size: 20px;
  letter-spacing: 0px;
  word-spacing: 0px;
  /* color: white; */
  font-weight: 700;
  font-style: normal;
}
tbody>tr{
    color:black;
}

tbody>tr:nth-child(even){
    color:rgb(175, 198, 216);
}

#box-choice-heading{
    font-size:28px;
    font-variant-caps: all-petite-caps;
    font-weight: bolder;
    color: black;
   
}

.add-teacher-row-heads{
    text-decoration: underline;
    color: black;
}

#actual-enrolled-teacher-list{
    font-size: 15px;
    display: flex;
    flex-wrap: wrap;
}

#enrolled-teacher-list{
    font-size: 13px;
}
#teacher-id-value{
font-size: 12px;
font-variant: small-caps;
font-weight: 500;
}
#add-teacher-student-click {
  color:rgb(72, 131, 209);
  font-size: 25px;
}

#add-teacher-student-click:hover{
  cursor: pointer;
}
</style>