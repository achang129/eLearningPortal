<template>
 <div class="dash-container">
   <header class="dashboardheader">
     <img src="../assets/studentdashboard.png" alt="Student Dashboard Banner">
   </header>
  <StudentWorkView class="studentdeets" v-bind:id="parseInt($route.params.id)" v-bind:course="parseInt($route.params.course)" v-if='$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"'></StudentWorkView>
  <user-sidebar class="dash-sidebar"/>
 </div>
</template>

<script>
import StudentWorkView from '../components/StudentWorkView.vue'
import UserSidebar from '../components/UserSidebar.vue'

export default {
  components: { StudentWorkView, UserSidebar },
   data() {
    return {
    }
  },
    methods: {
    },
    created() {
  }
}
</script>

<style>
.dash-container {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
  grid-template-areas: 
  ". header header header ."
  "sidebar teachercourses teachercourses teachercourses .";
}



.dash-sidebar{
  grid-area: sidebar;
  display: flex;
  align-self:flex-start;
  justify-content: flex-start;
  
}

.studentdeets{
  display: inline-block;
  grid-area: teachercourses;
  font-family: Georgia, 'Times New Roman', Times, serif;
  margin-top: 20px;
}

.dashboardheader{
   display: flex;
  justify-content: center;
  grid-area: header;
  width: 100%;
}

.dashboardheader img{
   border: solid black;
  border-radius: 24px;
  height: 17rem;
  width: 100%;
}
</style>