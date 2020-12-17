<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div class="homework" v-else>
      <assignment-form v-bind:id="parseInt($route.params.id)" />
    </div>
</template>

<script>
import AssignmentForm from "@/components/AssignmentForm.vue";
import LoadingScreen from '../components/LoadingScreen.vue';
export default {
  name: "homework-form",
  components: {
    AssignmentForm,
    LoadingScreen
  },
  data() {
      return {
        isLoading: true,
      }
    },
    mounted () {
      setTimeout(() => {
      this.isLoading = false
    }, 1000)
    }
};
</script>

<style>

</style>