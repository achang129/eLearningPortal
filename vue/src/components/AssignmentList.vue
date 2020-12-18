<template>
  <div>
    <div v-for="assignment in this.assignments" v-bind:key="assignment.id" class="course-values">
       <h3 class="assignheaders">{{ assignment.name }} <span id="assign-id-value">(Assignment id: {{assignment.id}})</span></h3>
       <p id="assign-description-summary">{{assignment.description}}</p>
       <router-link class="details-link" :to="{ name: 'homework-form', params: {id: assignment.id} }">View Assignment</router-link>
       <p id="assign-status">{{assignment.status}}</p>
    </div>
    <br>
    <br>
  </div>
</template>

<script>
import homeworkService from "@/services/HomeworkService.js";
import gradeService from "@/services/GradeService.js";

export default {
  name: "sh-list",
  data() {
    return {
      errorMsg: "",
      assignments: []
    }
  },
  methods: {
    makeList() {
      this.assignments = [];
      homeworkService.list().then(response => {
        this.assignments = response.data.map((work)=>{
          return {
            'name':work.name,
            'description':work.description,
            'id':work.id,
            'due':work.dueDate,
            'status':'unknown'
          }
        });
        
        this.getStatus();
      });
    },
    getStatus(){
      this.assignments.forEach((work)=>{
        homeworkService.submitted(work.id).then(response=>{
          switch(response.data){
          case 'unsubmitted':
            work.status = 'Due ' + work.due;
            break;
          case 'submitted':
            work.status = 'Submitted!';
            break;
          case 'graded':
            gradeService.get(work.id).then((response)=>{work.status = 'Grade: ' +response.data[0].grade + "\n" + response.data[0].comment;});
            break;
          }
        });
      });
    }
  },
  created() {
    this.makeList();
  }
}
</script>

<style>
.details-link{
  color:rgb(184, 201, 214);
}


.assignheaders {
  margin-bottom: 0px;
}

.main-link{
  color:rgb(184, 201, 214);
}

.main-link:hover {
  cursor: pointer;
}

.main-link::before{
    content: " ";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

  #all-courses-table-caption{
    font-size: 30px;
  }
  .table-rows{
    font-size: 20px;
  }

  .assign-values{
    color:rgb(175, 198, 216);
    text-align: center;
    position: relative;
    font-size: 20px;
    font-variant-caps: petite-caps;
    border: solid black;
    display: flex;
    flex-direction: column;
    margin-top: 10px;
    margin-right: 10px;
    margin-left: 10px;
    border-radius: 20px;
    background-color:#3a3535;
    opacity: 80%;
  }
  #assign-id-value{
    font-size: 13px;
    font-variant: small-caps;
    font-weight: 100;
  }
  .assign-values p{
    margin-left: 5px;
  }
  #assign-description-summary {
    font-style: italic;
    font-size: 18px;
    font-variant-caps: unicase;
  }

  .assign-values:nth-child(even){
    color: black;
    background-color: rgb(67, 136, 141);
    opacity: 80%;
  }
</style>