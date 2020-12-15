<template>
 <div>
  <teacher-student-details v-if='$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"'/>
  <admin-student-details v-if='$store.state.user.authorities[0]["name"]=="ROLE_ADMIN"' />
 </div>
</template>

<script>
import AdminStudentDetails from '../components/AdminStudentDetails.vue'
import TeacherStudentDetails from '../components/TeacherStudentDetails.vue'
export default {
  components: { TeacherStudentDetails, AdminStudentDetails },

}
</script>

<style>

</style>