<template>
    <div>
        <h3>{{name}}</h3>
        <p>{{description}}</p>
        <form v-on:submit.prevent='submit()'>
          <div v-for="(question, index) in questions" v-bind:key='index'>
            <h4>Question {{index + 1}} ({{question.points}} pts):</h4>
            <p>{{question.statement}}</p>
            <div v-if="question.type=='text'" class=text-answer>
              <textarea v-model="answers[index]"></textarea>
            </div>
            <div v-else class=mc-answer>
              <div v-for="(answer, aindex) in question.answers" v-bind:key='aindex' class='mc-answer' v-bind:class="{'selected': isSelected(index,aindex)}" v-on:click.prevent='selectAnswer(index, aindex)'>
                <p>{{answer}}</p>
              </div>
            </div>
            <button v-on:click.prevent=clear()>Clear Answers</button>
            <button v-on:click.prevent=save()>Save Progress</button>
            <button type=submit>Submit Homework</button>
          </div>
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
          answers: []
        }
    },
    props: ["id"],
    computed: {
      isSelected(q, a){
        return (questions.type=='mc'?questions[q]:questions[q][a])==a;
      }
    },
    methods: {
      clear(){
        this.answers = this.questions.map((q)=>{return q.type=='mmc'?q.answers.map(()=>{return 0;}):''});
      },
      save(){
        for(let i=0;i<this.answers.length;i++){
          if(questions[i].type==mcc){
            let ans = this.answers[i].reduce((acc,val)=>{return acc+(val>0? '':','+val);});
            homeworkService.saveHomeworkProgress(this.id,i,ans);
          }else{
            homeworkService.saveHomeworkProgress(this.id,i,this.answers[i]);
          }
        }
      },
      submit(){
        save();
        homeworkService.submitHomework(this.id);
      },
      selectAnswer(q, a){
        if(questions[q].type == 'mc'){
          answers[q]=a;
        }else{
          answers[q][a] = a-answers[q][a];
        }
      }
    },
    created() {
      homeworkService.get(this.id).then(response=>{
        this.name = response.data.name;
        this.description = response.data.description;
        this.dueDate = response.data.dueDate;
        this.questions = response.data.questions.map((question)=>{
          let q = {
            'type': question.type,
            'statement': question.statement,
            'answers': question.answers,
            'points': question.points
          };
          if(question.type = 'text'){q.answers = [];}
          return q;
        });
        this.answers = this.questions.map((q)=>{return q.type=='mmc'?q.answers.map(()=>{return -1;}):''});
      });
    }
  }
</script>