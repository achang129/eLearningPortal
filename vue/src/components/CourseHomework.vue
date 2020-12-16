<template>
  <div>
    <div v-for="assignment in this.assignments" v-bind:key="assignment.id" class="assignment-values">
       <h3 class="assignmentheaders">{{ assignment.title }} <span id="assignment-id-value">(Assignment id: {{assignment.id}})</span></h3>
       <p id="assignment-description-summary">{{assignment.description}}</p>
        <button class="deleteassignment-btn" v-if='$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"' v-on:click.prevent="deleteAssignment(assignment.id)">Delete</button> 
    </div>
    <br>
    <br>
  </div>
</template>

<script>
import homeworkService from "@/services/HomeworkService.js";

export default {
  name: "assignment-list",
  data() {
    return {
      errorMsg: "",
      assignments: []
    }
  },
  methods: {
    makeAssignmentList() {
      homeworkService.list().then(response => {
        response.data.forEach((assignment)=>{this.assignments.push(assignment);});
      });
    },
    deleteAssignment(id) {
      homeworkService.deleteAssignment(id)
        .then(response => {
          if (response.status === 200) {
            this.assignments = this.assignments.filter((assignment)=>{return assignment.id !== id;});
          }
        }).catch(error => {
          if (error.response) {
            this.errorMsg = error.response.statusText;
          }
        });
    }
  },
  created() {
    this.makeAssignmentList();
  }
}
</script>

<style scoped>
.deleteassignment-btn {
	box-shadow: 3px 4px 0px 0px #8a2a21;
	background:linear-gradient(to bottom, #c62d1f 5%, #f24437 100%);
	background-color:#c62d1f;
	border-radius:18px;
	border:1px solid #d02718;
	display:flex;
  justify-content: center;
  align-self: center;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:17px;
	padding:7px 25px;
	text-decoration:none;
	text-shadow:0px 1px 0px #810e05;
  width: 8%;
  margin-top: 10px;
  margin-bottom: 10px;
  
}
.deleteassignment-btn:hover {
	background:linear-gradient(to bottom, #f24437 5%, #c62d1f 100%);
	background-color:#f24437;
}
.deleteassignment-btn:active {
	position:relative;
	top:1px;
}

.assignmentheaders {
  margin-bottom: 0px;
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

  #all-assignments-table-caption{
    font-size: 30px;
  }
  .table-rows{
    font-size: 20px;
  }

  .assignment-values{
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
    background-color:#d69089;
    opacity: 80%;
  }
  #assignment-id-value{
    font-size: 13px;
    font-variant: small-caps;
    font-weight: 100;
  }
  .assignment-values p{
    margin-left: 5px;
  }
  #assignment-description-summary {
    font-style: italic;
    font-size: 18px;
    font-variant-caps: unicase;
  }

  .assignment-values:nth-child(even){
    background-color: rgb(83, 189, 83);
    opacity: 80%;
  }
</style>