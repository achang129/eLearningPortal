<template>
  <div>
    <h2>Assignment Information</h2>
      <textarea label="Title" cols="30"></textarea>
      <textarea label="Description" cols="30" rows="10" style="display: flex"></textarea>
      <assignment-info /> 
    <h3>Assignment Questions</h3>
      <assignment-question />
      <create-question :action="createAssignment" actionName="Create" />
  </div>   
</template>

<script>
import AssignmentInfo from '../components/AssignmentInfo';  
import AssignmentQuestion from '../components/AssignmentQuestion.vue';
import CreateQuestion from '../components/CreateQuestion.vue';

export default {
  name: 'create-assignment',
  components: {
    AssignmentInfo,
    AssignmentQuestion,
    CreateQuestion      
  }
}
</script>