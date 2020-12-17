<template>
  <div class="course-container">
    <div class="course-details-heading">
      <div id="course-details-heading">
        <div>Course Id: {{this.$route.params.id}}</div>
        <div>Class: {{course.name}}</div>
        <div>Description: {{course.description}}</div>
        <div>Class Limit: {{course.classSize}}</div>
        <div>Cost: {{course.cost}}</div>
      </div>

      <div>
        <table class="student-table">
            <thead>
                <tr>
                  <th>Student Name:</th>
                  <th>Student Grade:</th>
                </tr>  
            </thead>
            <tbody>
              <tr v-for="student in students" v-bind:key="student.id">
                  <td> {{ student.student }}</td>
                  <td> {{ student.grade }}%</td>
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
      console.log(this.$route.params.id)
      CourseService.getCoursework(id)
      .then(response => {
        console.log(this.$route.params.id)
        this.course = response.data;
      });
      CourseService.getAllGradesForCourse(id)
        .then(response => {
          this.students = response.data;
        })
      
    }
  },
  created() {
    console.log(this.$route.params.id)
    this.getStudentGrades(this.$route.params.id);
  }
};

</script>

<style>
.course-container{
  display: grid;
  grid-template-columns: .5fr 1fr 1fr 1fr;
  grid-template-areas: 
  ". detailsheading detailsheading detailsheading"
  "sidebar . . .";

}

.course-details-heading{
  grid-area: detailsheading;
  width: 100%;
}

.deets-sidebar{
  grid-area: sidebar;
  width: 100%;
}

tbody>tr {
  background-color: rgb(67, 136, 141);
}

tbody>tr:nth-child(even) {
  background-color: #3a3535;
}
</style>