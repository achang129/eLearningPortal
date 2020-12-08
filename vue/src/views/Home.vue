<template>
  <div class="home">
    <h1>Home</h1>
    <div><router-link to="/course">Courses</router-link>&nbsp;</div>
    <router-link to="/homework">Homework</router-link>&nbsp;
  </div>
</template>

<script>
export default {
  name: "home"
};
</script>
