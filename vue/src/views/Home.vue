<template>
  <div class="home">
    <header class="homeHeader">
      <img src="../assets/homeBanner.png" alt="Home Banner">
    </header>
    <dev-header />
    <!-- <h1>Home</h1> -->
    <!-- <div><router-link to="/course">Courses</router-link>&nbsp;</div>
    <router-link to="/homework">Homework</router-link>&nbsp; -->
  </div>
</template>

<script>
import DevHeader from '../components/DevHeader.vue';
export default {
  components: { DevHeader },
  name: "home"
};
</script>

<style>
.homeHeader {
  display: flex;
  justify-content: space-around;
  padding-top: 10px;
}

.homeHeader img {
  border-radius: 24px;
}

.home {
  background-color: #05AED8 ;
}
</style>