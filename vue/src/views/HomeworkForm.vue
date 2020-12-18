<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div class="homework" v-else>
      <router-link v-if='$store.state.user.authorities[0]["name"]=="ROLE_STUDENT"' class="details-link" :to="{ name: 'all-homework' }">Go Back to Assignments</router-link>
      <router-link v-else class="details-link" :to="{ name: 'all-courses' }">Go Back to Courses</router-link>
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
.details-link{
  color:rgb(184, 201, 214);
}
</style>