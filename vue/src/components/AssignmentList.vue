<template>
  <div>
    <div v-for="assignment in this.assignments" v-bind:key="assignment.id" class="course-values">
       <h3 class="assignheaders">{{ assignment.name }} <span id="assign-id-value">(Assignment id: {{assignment.id}})</span></h3>
       <p id="assign-description-summary">{{assignment.description}}</p>
       <router-link class="details-link" :to="{ name: 'homework-form', params: {id: assignment.id} }">View Assignment</router-link>
    </div>
    <br>
    <br>
  </div>
</template>

<script>
import homeworkService from "@/services/HomeworkService.js";

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
      homeworkService.list().then(response => {
        response.data.forEach((work)=>{this.assignments.push(work);});
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