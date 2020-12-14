<template>
  <div>
    <h1>Assignment Information</h1>
      <assignment-info /> 
    <h1>Assignment Questions</h1>
      <assignment-question />
      <create-question />
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