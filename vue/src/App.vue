<template>
  <div id="app" >
    <!-- <dev-header/> -->
    <router-view />
  </div>
</template>

<script>
import DevHeader from './components/DevHeader.vue';
export default {
  components: { DevHeader },
  
}
</script>

<style>

</style>