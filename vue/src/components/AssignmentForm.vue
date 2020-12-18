<template>
    <div>
        <h3>{{name}}</h3>
        <p>{{description}}</p>
        <p v-if='submitted'>This assignment has already been submitted!</p>
        <form v-on:submit.prevent='submit()'>
          <div v-for="(question, index) in questions" v-bind:key='index'>
            <h4>Question {{index + 1}} ({{question.weight}} pts):</h4>
            <p>{{question.statement}}</p>
            <div v-if="question.type=='text'" class="text-answer">
              <textarea :disabled='submitted' v-model="answers[index]"></textarea>
            </div>
            <div v-else class="mc-answer">
              <div v-for="(answer, aindex) in question.answers" v-bind:key='aindex' v-bind:class="{ 'selected':answer.selected }" v-on:click.prevent='selectAnswer(index, aindex)'>
                <p>{{answer.text}}</p>
              </div>
            </div>
          </div>
          <button :disabled='submitted' v-on:click.prevent=clear()>Clear Answers</button>
          <button :disabled='submitted' v-on:click.prevent=save()>Save Progress</button>
          <button :disabled='submitted' type=submit>Submit Homework</button>
        </form>
    </div>
</template>

<script>
  import homeworkService from "../services/HomeworkService";

  export default {
    name: "assignment-form",
    data() {
        return {
          name: '',
          description: '',
          dueDate: '',
          questions: [],
          answers: [],
          submitted: false
        }
    },
    props: ["id"],
    methods: {
      clear(){
        this.questions.forEach((q)=>{q.answers.forEach((a)=>{a.selected=false;});});
        this.answers = this.answers.map(()=>'');
      },
      save(){
        for(let i=0;i<this.answers.length;i++){
          homeworkService.saveHomeworkProgress(this.id,i+1,this.answers[i]);
        }
      },
      submit(){
        this.save();
        homeworkService.submitHomework(this.id);
        this.$router.push('/homework');
      },
      selectAnswer(q, a){
        if(!this.submitted){
          if(this.questions[q].type == 'mc'){
            this.answers[q]=a;
            this.questions[q].answers.forEach((a)=>{a.selected=false;});
            this.questions[q].answers[a].selected=true;
          }else{
            this.questions[q].answers[a]=!this.questions[q].answers[a];
            this.answers[q] = this.questions[q].answers.reduce((acc,val,i)=>{return val.selected?acc+','+i:acc;},'');
          }
        }
      }
    },
    mounted() {
      homeworkService.get(this.id).then(response=>{
        this.name = response.data.name;
        this.description = response.data.description;
        this.dueDate = response.data.dueDate;
        this.questions = response.data.questions.map((question)=>{
          let q = {
            'type': question.type,
            'statement': question.statement,
            'answers': question.answers.map((a)=>{return {'text':a,'selected':false};}),
            'weight': question.weight
          };
          if(question.type == 'text'){q.answers = [];}
          return q;
        });
        this.clear();
        this.answers = response.data.answers;
        for(let i=0;i<this.answers.length;i++){
          if(this.questions[i].type!='text' && this.answers[i] != ''){
            this.answers[i].split(',').forEach((j)=>{this.questions[i].answers[j].selected=true;});
          }
        }
      });
      
      homeworkService.submitted(this.id).then(response=>{
        if(response.data!='unsubmitted'){
          this.submitted=true;
        }
      });
    }
  }
</script>

<style>
.selected{
  color:white;
}
</style>