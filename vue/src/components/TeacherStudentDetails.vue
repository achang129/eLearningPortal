<template>
  <div class="course">
    <div id="course-details-heading">
      <div>Course Id: {{this.id}}</div>
      <div>Class: {{course.name}}</div>
      <div>Description: {{course.description}}</div>
      <div>Class Limit: {{course.classSize}}</div>
      <div>Cost: {{course.cost}}</div>
    </div>

    <div>
      <table class="student-table">
          <thead>
              <th>Student Name:</th>
              <th>Student Grade:</th>
              <th>Student Progress:</th>
          </thead>
          <tr v-for="student in students" v-bind:key="student.id">
              <td> {{ student.student }}</td>
              <td> {{ student.grade }}</td>
              <!-- <td> {{ }}</td> needs to be fixed or removed -->
          </tr>
      </table>
    </div>
  </div>
</template>

<script>
import CourseService from '../services/CourseService';




export default {
  components: { },
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
      CourseService.getAllGradesForCourse(id)
      .then(response => {
        this.students = response.data;
      });
    }
  },
  created() {
    this.getStudentGrades();
  }
};

</script>

<style>

</style>