<template>
  <div>
    <h1>Add New Homework</h1>
    <create-homework v-bind:courseId="parseInt(this.$route.params.courseId)" />
  </div>
</template>

<script>
import CreateHomework from '../components/CreateHomework.vue';

export default {
  components: {
    CreateHomework
  }
};
</script>