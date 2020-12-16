<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div id="messages-view-page" v-else>
      <header class="mess-header">
        <img src="../assets/messagesbanner.png" alt="Message Banner">
      </header>
      <div>
        <message-notifications id="messages-notifications-container"/>
      </div>
      <div id="messages-page-sidebar">
        <user-sidebar/>
      </div>
        
    </div>
</template>

<script>
import UserSidebar from "../components/UserSidebar.vue"
import MessageNotifications from "../components/MessageNotifications.vue"
import LoadingScreen from '../components/LoadingScreen.vue'

export default {
  components: {UserSidebar, MessageNotifications, LoadingScreen},
  data() {
      return {
        isLoading: true
      }
    },
    mounted () {
      setTimeout(() => {
      this.isLoading = false
    }, 1000)
    }
}
</script>

<style>
.mess-header{
   display: flex;
  justify-content: space-around;
  grid-area: header;
}

.mess-header img{
  border: solid black;
  border-radius: 24px;
  height: 17rem;
  width: 100%;
}

#messages-notifications-container {
  grid-area: messages;
}
#messages-page-sidebar {
  grid-area: sidebar;
}

#messages-view-page {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
  grid-template-areas:
  ". header header header ."
  "sidebar messages messages messages .";
}
</style>