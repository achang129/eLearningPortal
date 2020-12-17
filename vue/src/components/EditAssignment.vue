<template>
    <div class="editor-container">
        <label for="due-date">Due Date: </label>
        <input class="form-control-date" type="date" v-model="assignment.dueDate"/> 
        <div>
            <textarea class="form-control-lesson" v-model="assignment.title" placeholder="Title" label="Title" cols="30"></textarea>
        </div>
        <div>
            <textarea class="form-control-lesson" v-model="assignment.description" placeholder="Description" label="Description" cols="30" rows="10" style="display: flex"></textarea>
        </div>
        <div class="assignment-question" v-for="(item, questionIndex) in assignment.questions" :key="questionIndex" focusable>
            <h2 slot="header">Question {{questionIndex + 1}}:</h2>
            <button @click.prevent="removeQuestion(questionIndex)">Remove Question {{questionIndex + 1}}</button>
            <br/>
            <br/>
            <form>
                  <div class="points-section">
                    
                    <input type="number" label="Points"  v-model.number="item.weight" >
                    <label> # of Points</label>
                    
                </div>
                <div>
                    
                    <textarea class="form-control-lesson" placeholder="Enter Question" label="Question" v-model="item.question"></textarea>
                    <label> Question </label>
                </div>
              
                <div v-for="(ans, answerIndex) in item.answers" :key="answerIndex">
                  <div>
                        
                  <br/>
                    <textarea class="form-control-lesson" placeholder="Answer Option" label="Answer" v-model="item.answers[answerIndex]"></textarea>
                    <label> Answer {{ answerIndex + 1 }} </label>
                  </div>
                  <div>
                      
                    <input type="checkbox" v-on:change="toggleCorrect(questionIndex, answerIndex)">
                     <label> Correct Answer</label>
                     <br/>
                     <br/>
                  </div>
                   <button @click.prevent="removeAnswer(questionIndex, answerIndex)">Remove Answer {{ answerIndex + 1 }}</button>
                </div>
                  <br/>
                  <br/>
                <div>
                    <button style="display: block" v-if="item.answers.length < 5" @click.prevent="addAnswer(questionIndex)">Add Answer</button>
                     <br/>
                     <br/>
                </div>
            </form>
        </div>
        <div class="assignment-footer">
            <div>
                <p>Total Points: {{totalPoints}}</p>
                 <button style="display: block" v-show="assignment.questions.length < 10" @click="addQuestion">Add Question</button>
                 <br/>
                <button @click.prevent="cancel">Cancel/Go Back</button> ---
                <button type="submit" @click.prevent="createAssignment">Create</button>
            </div>
        </div>
  </div>
</template>


<script>
import homeworkService from "../services/HomeworkService";

  export default {
    name: "edit-assignment",
    data() {
        return {
            assignment: {
                name: '',
                description: '',
                date: '',
                dueDate: '',
                course: 0,
                questions: []
            }
        }
    },
    computed: {
      totalPoints() {
        return this.assignment.questions.reduce((curr, question) =>
          question.weight + curr, 0);
      }
    },
    methods: {
        resetAssignment() {
            this.assignment = {
                'name': '',
                'description': '',
                'date': '',
                'dueDate': '',
                'course': 0,
                'questions': []
            }
        },
        addQuestion(){
            this.assignment.questions.push({
                'type':'text',
                'statement':'',
                'answers':[],
                'correct':[],
                'weight':1
            });
        },
        removeQuestion(index){
            this.assignment.questions.splice(index,1);
        },
        addAnswer(index){
            this.assignment.questions[index].answers.push('');
        },
        removeAnswer(qindex, aindex){
            this.assignment.questions[qindex].answers.splice(aindex,1);
        },
        toggleCorrect(qindex, aindex){
            this.assignment.questions[qindex].correct[aindex] = !this.assignment.questions[qindex].correct[aindex];
        },
        createAssignment() {
            this.assignment.questions.forEach((question)=>{
                if(question.answers.length>1){question.type='mmc';}
            });
            homeworkService.addHomework(this.assignment)
                .then(response => {
                if (response.status === 201) {
                    this.returnToCourse();
                }
                }).catch(error => {
                this.errorMsg = error.response.statusText;
                });
        },
        cancel(){
            this.returnToCourse();
        },
        returnToCourse(){
            this.$router.push('/courses/' + this.$store.state.activeCourse);
        }
    },
    created() {
        
    }
  }
</script>

<style>
.editor-container{
    /* border: solid black; */
    display: flex;
    justify-self: center;
}

.points-section{
    margin-bottom: 3px;
}
</style>