<template>
  <div>
      <table class="student-table">
          <thead>
              <tr>
                <th>Assignment:</th>
                <th>Answers:</th>
                <th>Correct:</th>
                <th>Grade:</th>
                <th>Comment:</th>
                <th>Submit:</th>
              </tr>  
          </thead>
          <tbody>
            <tr v-for="assignment in assignments" v-bind:key="assignment.id">
                <td> <router-link class="details-link" :to="{ name: 'homework-form', params: {id: assignment.id} }">{{assignment.name}}</router-link></td>
                <td>
                  <div v-for="(answer, i) in assignment.answers" v-bind:key=i>
                    <p>{{answer}}</p>
                  </div>
                </td>
                <td>
                  <div v-for="(question, i) in assignment.questions" v-bind:key=i>
                    <p>{{getCorrect(question)}}</p>
                  </div>
                </td>
                <td>
                  <form>
                  <input type="number" label="Points"  v-model.number="assignment.grade" ></form>
                </td>
                <td>
                  <textarea v-model="assignment.comment"></textarea>
                </td>
                <td>
                  <button v-on:click.prevent="submitGrade(assignment.id,assignment.grade,assignment.comment)">Submit</button>
                </td>
            </tr>
          </tbody>
      </table>
  </div>
</template>

<script>
import HomeworkService from '../services/HomeworkService';
import GradeService from '../services/GradeService';

export default {
  name: "student-work-list",
  props: ["id", "course"],
  data() {
    return {
        assignments: []
    }
  },
  computed: {},
  methods: {
    submitGrade(id, amount,comment){
      GradeService.updateGrade(this.id,id,amount,comment)
    },
    getCorrect(question){
      if(question.type=='text'){return question.answers[0];}
      return question.correct.reduce((acc,val,i)=>{return val?acc+','+question.answers[i]:acc;},'').substring(1);
    }
  },
  created(){
      HomeworkService.getStudentWork(this.id, this.course).then((response)=>{
        this.assignments = response.data.map((a)=>{
          return {
            'id':a.id,
            'name':a.name,
            'answers':a.answers,
            'questions':a.questions,
            'grade':0,
            'comment':''
          };
        });
        console.log(this.assignments);
      });
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