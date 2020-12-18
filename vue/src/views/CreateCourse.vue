<template v-if='this.$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"'>
  <loading-screen v-if="isLoading"></loading-screen>
    <div class="create-course" v-else>
      <button class="backtocoursesbtn" @click="$router.push({name: 'all-courses'})">Back to Courses</button>&nbsp;
      <h1>Add New Course</h1>
      <create-course/>
    </div>
</template>

<script>
import CreateCourse from '../components/CreateCourse.vue';
import LoadingScreen from '../components/LoadingScreen.vue';

export default {
  name: "create-curriculum",
  components: {
    CreateCourse,
    LoadingScreen
  },
  data() {
      return {
        isLoading: true
      }
    },
    mounted () {
      this.isLoading = false
    }
};
</script>

<style>
.backtocoursesbtn {
	box-shadow: 3px 4px 0px 0px #4e4d4d;
	background:linear-gradient(to bottom, #265c7c 5%, #604072 100%);
	
	border-radius:18px;
	border:1px solid #111010;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:17px;
	padding:7px 25px;
	text-decoration:none;
	text-shadow:0px 1px 0px #810e05;
}
.backtocoursesbtn:hover {
	background:linear-gradient(to bottom, #f24437 5%, #c62d1f 100%);
	background-color:#f24437;
}
.backtocoursesbtn:active {
	position:relative;
	top:1px;
}
</style>