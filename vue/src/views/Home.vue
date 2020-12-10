<template>
  <div class="home">
    <header class="homeHeader">
      <img src="../assets/homeBanner.png" alt="Fancy Blue Home Banner yaaaaayyyyyyyyyyy">
    </header>
    <user-sidebar v-if="$store.state.token != ''"/>
    <login-register-header v-if="$store.state.token == ''"/>
  </div>
</template>

<script>
import UserSidebar from '../components/UserSidebar.vue';
import LoginRegisterHeader from '../components/LoginRegisterHeader.vue';
export default {
  components: { UserSidebar, LoginRegisterHeader },
  name: "home"
};
</script>

<style>
.homeHeader {
  display: flex;
  justify-content: space-around;
 
}

.homeHeader img {
  border: solid black;
  border-color: rgb(155, 180, 202);
  border-radius: 24px;
  height: 17rem;
  width: 70%;
}

.home {
  background-color: #33b3d3c7 ;
}
</style>