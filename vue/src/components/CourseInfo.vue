<template>
  <div class="curricula">
    <h3>{{course.name}}</h3>
    <div>Description: {{course.description}}</div>
    <div>Difficulty: {{course.difficulty}}</div>
    <div>Cost: {{course.cost}}</div>
    <div class="daily">
      <h4>Curriculum</h4>
      <div>
        <table>
          <thead>
            <tr>
              <th>Date</th>
              <th>Lesson Plan</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="curriculum in this.curricula" v-bind:key="curriculum.date">
              <td>{{curriculum.date}}</td>
              <td>{{curriculum.lesson}}</td>
            </tr>
          </tbody>
        </table>
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
import courseService from "@/services/CourseService.js";

export default {
  name: "curricula",
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
    getCourse() {
      courseService.get(this.id).then(response => {
        this.course = response.data;
        console.log(this.course);
      });
    },
    addCurriculum() {
      console.log('test');
      courseService.addCurriculum(this.id,this.newLesson,this.newDate).then(response => { 
      })
    }
  },
  created() {
    this.getCourse();
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