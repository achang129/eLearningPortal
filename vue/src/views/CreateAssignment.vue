<template v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"'>
  <div class="maindiv">
    <header class="hw-create-banner">
      <img src="../assets/hwcreatorbanner.png" alt="Homework Creator Banner">
    </header>
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
    grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
    grid-template-areas: 
    ". header header header ."
    ". editor editor editor .";
  }

 .hw-create-banner {
  display: flex;
  justify-content: center;
  width: 100%;
  grid-area: header;
}

.hw-create-banner img {
  border: solid black;
  border-radius: 24px;
  height: 17rem;
  width: 100%;
}

  .editor{
    grid-area: editor;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

</style>