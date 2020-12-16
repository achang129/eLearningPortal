<template v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"'>
  <div>
    <h1>Assignment Information</h1>
      <edit-assignment /> 
  </div>   
</template>

<script>
import EditAssignment from '../components/EditAssignment';

export default {
  name: 'create-assignment',
  components: {
    EditAssignment
  }
}
</script>