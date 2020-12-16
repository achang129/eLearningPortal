<template>
  <div class="course">
    <div>
      <table class="student-table">
          <thead>
              <th>Student Name:</th>
              <th>Student Grade:</th>
          </thead>
          <tr v-for="student in students" v-bind:key="student.id">
              <td> {{ student.student }}</td>
              <td> {{ student.grade }}</td>
          </tr>
      </table>
    </div>
  </div>
</template>

<script>
import courseService from "../services/CourseService.js"



export default {
  components: { },
  name: "admin-student-details",
  data() {
    return {
      students: []
    }
  },
  computed: {},
  methods: {
    getAllStudents(){
        courseService.getAllGPAs()
        .then(response => {
          this.students = response.data;
        });
    }
  },  
  created() {
    this.getAllStudents();
  }
};

</script>

<style scoped>
  td {
    color: white;
  }
</style>