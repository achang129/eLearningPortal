<template>
  <div>
    <h1>Assignment Information</h1>
      <assignment-info /> 
    <h1>Assignment Questions</h1>
      <assignment-question />
  </div>   
</template>

<script>
import AssignmentInfo from '../components/AssignmentInfo';  
import AssignmentQuestion from '../components/AssignmentQuestion.vue';

export default {
  name: 'create-assignment',
  components: {
    AssignmentInfo,
    AssignmentQuestion
  }
}
</script>