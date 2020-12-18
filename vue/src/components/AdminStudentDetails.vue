<template>
  <div class="course">
    <div>
      <table class="student-table">
          <thead>
              <th>Student Name:</th>
              <th>Student Grade:</th>
          </thead>
          <tbody>
            <tr v-for="student in students" v-bind:key="student.id">
                <td> {{ student.student }}</td>
                <td> {{ formatGrade(student.gpa) }}</td>
            </tr>
          </tbody>
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
    },
    formatGrade(grade){
      if(grade<0){return'-';}
      return grade/100;
    }
  },  
  created() {
    this.getAllStudents();
  }
};

</script>

<style scoped>
  tbody>tr {
  background-color: rgb(67, 136, 141);
}

tbody>tr:nth-child(even) {
  background-color: #3a3535;
}
</style>