<template>
  <div class="curricula">
    <router-link to="/course/create">Add Course</router-link>&nbsp;|&nbsp;
    <table>
      <thead>
        <tr>
          <th>Course</th>
          <th>Difficulty</th>
          <th>Cost</th>
          <th>Edit</th>
          <th>Delete</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="course in this.courses" v-bind:key="course.id">
          <td>{{ course.name }}</td>
          <td>{{ course.difficulty }}</td>
          <td>{{ course.cost }}</td>
          <td>
            <router-link :to="{ name: 'course-details', params: {id: course.id} }">View Details</router-link>
          </td>
          <td>
            <a href="#" v-on:click.prevent="deleteCourse(course.id)">Delete</a>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import courseService from "@/services/CourseService.js";

export default {
  name: "curricula",
  data() {
    return {
      errorMsg: "",
      courses: []
    }
  },
  methods: {
    makeCourseList() {
      courseService.list().then(response => {
        response.data.forEach((course)=>{this.courses.push(course);});
      });
    },
    deleteCourse(id) {
      courseService.deleteCourse(id)
        .then(response => {
          if (response.status === 200) {
            this.courses = this.courses.filter((course)=>{return course.id !== id;});
          }
        }).catch(error => {
          if (error.response) {
            this.errorMsg = error.response.statusText;
          }
        });
    }
  },
  
  created() {
    this.makeCourseList();
  }
};

</script>

<style>
.course-list {
  margin: 0 auto;
  max-width: 800px;
}
.course {
  font-size: 24px;
  border-bottom: 1px solid #f2f2f2;
  padding: 10px 20px;
}
.course:last-child {
  border: 0px;
}
table {
  text-align: left;
  width: 800px;
  border-collapse: collapse;
}
td {
  padding: 4px;
}
tbody tr:nth-child(even) {
  background-color: #f2f2f2;
}

.course-list a:link,
.course-list a:visited {
  color: blue;
  text-decoration: none;
}
.course-list a:hover {
  text-decoration: underline;
}
</style>