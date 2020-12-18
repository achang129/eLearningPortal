<template>
  <div class="course-container">
    <header class ="inner-teacher-dashboard-header">
      <img src="../assets/studentdashboard.png" alt="Student Dashboard Banner">
    </header>
    <div class="course-details-heading-tsd">
      <div id="course-details-heading-tsd">
        <div>Course Id: {{this.$route.params.id}}</div>
        <div>Class: {{course.name}}</div>
        <div>Description: {{course.description}}</div>
        <div>Class Limit: {{course.classSize}}</div>
        <div>Cost: {{course.cost}}</div>
      </div>

      <div id="grid-holder">
        <table class="student-table">
            <thead>
                <tr>
                  <th>Student Name:</th>
                  <th>Student Grade:</th>
                  <th>View Assignments:</th>
                </tr>  
            </thead>
            <tbody>
              <tr v-for="student in students" v-bind:key="student.id">
                  <td> {{ student.student }}</td>
                  <td> {{ formatGrade(student.grade) }}</td>
                  <td>
                    <router-link :to="'/studentwork/'+student.id+'/'+$route.params.id">Details</router-link>
                  </td>
              </tr>
            </tbody>
        </table>
      </div>
    </div>
    <user-sidebar class="deets-sidebar" />
  </div>
</template>

<script>
import CourseService from '../services/CourseService';
import userSidebar from '../components/UserSidebar'

export default {
  components: { userSidebar },
  name: "teacher-student-details",
  props: ["id"],
  data() {
    return {
      course: {
        'name': "",
        'description': "",
        'cost': 0,
        'dates': [],
        'curricula': []
      },
      students: []
    }
  },
  computed: {},
  methods: {
    getStudentGrades(id) {
      CourseService.getCoursework(id)
      .then(response => {
        this.course = response.data;
      });
      CourseService.getAllGradesForCourse(id)
        .then(response => {
          this.students = response.data;
        })
      
    },
    formatGrade(grade){
      if(grade<0){return'-';}
      return grade + ' %';
    }
  },
  created() {
    this.getStudentGrades(this.$route.params.id);
  }
};

</script>

<style>
.inner-teacher-dashboard-header{
   display: flex;
  justify-content: center;
  width: 100%;
  grid-area: banner;
}

.inner-teacher-dashboard-header img{
    border: solid black;
  border-radius: 24px;
  height: 17rem;
  width: 100%;
}

.course-container{
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
  grid-template-areas: 
  ". banner banner banner ."
  "sidebar detailsheading detailsheading detailsheading .";

}

#course-details-heading-tsd{
  /* width: 80%; */
    background-color:#3a3535;
  opacity: 70%;
  border-radius: 2%;
  border-style:ridge;
  border-color: black;
  width: 97%;
  font-family: "Trebuchet MS", Helvetica, sans-serif;
  font-size: 20px;
  letter-spacing: 0px;
  word-spacing: 0px;
  color: rgb(175, 198, 216);
  font-weight: 700;
  font-style: normal;
  font-variant: small-caps;
  text-transform: capitalize;
  margin-top: 15px;
  margin-left: 10px;
}

.course-details-heading-tsd{
  grid-area: detailsheading;
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 50px;
  /* margin: 1rem 5rem 0rem 0rem; */
}

.deets-sidebar{
  grid-area: sidebar;
  width: 100%;
}

tbody>tr {
  background-color: rgb(67, 136, 141);
  color:black;
}

tbody>tr:nth-child(even) {
  background-color: #3a3535;
  color:rgb(175, 198, 216);
}
</style>