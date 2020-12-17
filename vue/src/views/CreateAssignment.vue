<template v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"'>
  <div class="maindiv">
    <h1 class="header">Assignment Creator</h1>
    <edit-assignment class="editor"/> 
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
<style >
  .maindiv {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-areas: 
    "header header"
    "editor editor";
  }

  .header{
    grid-area: header;
    display: flex;
    justify-content: center;
  }

  .editor{
    grid-area: editor;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

</style>