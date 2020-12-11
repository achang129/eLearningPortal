<template>
  <div class="course">
      <select-teacher>
      </select-teacher>
    <div id="course-details-heading">
      <div>Class: {{course.name}}</div>
      <div>Description: {{course.description}}</div>
      <div>Difficulty: {{course.difficulty}}</div>
      <div>Cost: {{course.cost}}</div>
    </div>
    <div class="daily">
      <div id="curricula-container">
        <table id="curriculum-table" style="width:100%">
          <caption>Upcoming coursework:</caption>
          <thead>
            <tr>
              <th id="date-column">Date</th>
              <th id="lesson-column">Lesson Plan</th>
              <th id="homework-column">Homework</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="curriculum in this.curricula" v-bind:key="curriculum.date">
              <td class="curriculum-datum">{{curriculum.date}}</td>
              <td class="curriculum-datum">{{curriculum.lesson}}</td>
              <td class="curriculum-datum">TODO homework section</td>
            </tr>
          </tbody>
        </table>
        <br>
        <br>
        <br>
      </div>
      <form v-on:submit.prevent="addCurriculum">
        <label>Date</label>
        <input type="date" v-model="newDate" />
        <label>Lesson Plan</label>
        <input type="text" v-model="newLesson" />
        <label>Add Curriculum</label>
        <input type="submit" />
      </form>
    </div>
  </div>
</template>

<script>
import courseService from "../services/CourseService.js";
import SelectTeacher from "./SelectTeacher.vue";

export default {
  components: { SelectTeacher },
  name: "course",
  props: ["id"],
  data() {
    return {
      errorMsg: "",
      course: [],
      newLesson: "",
      newDate: new Date()
    }
  },
  computed: {
    curricula: function(){
      let c = [];
      for(let i=0;i<this.course.dates.length;i++){
        c[i] = {date: this.course.dates[i],lesson: this.course.curricula[i].lesson};
      }
      return c;
    }
  },
  methods: {
    getCoursework() {
      courseService.getCoursework(this.id).then(response => {
        this.course = response.data;
      });
    },
    addCurriculum() {
      console.log('test');
      courseService.addCurriculum(this.id,this.newLesson,this.newDate).then(response => { 
        if (response.status==201){
          this.newLesson= "";
          this.newDate= new Date();
          this.getCoursework();
        }
      })
    }
  },
  created() {
    this.getCoursework();
  }
};

</script>

<style>
#curricula-container{
  display:flex;
  flex-direction: column;
  justify-content: center;
}
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
.curriculum-datum {
  font-size: 15px;
}
</style>