<template>
  <div id="messages-view-page">
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

export default {
  components: {UserSidebar, MessageNotifications},
}
</script>

<style>

#messages-notifications-container {
  grid-area: messages;
}
#messages-page-sidebar {
  grid-area: sidebar;
}

#messages-view-page {
  display: grid;
  grid-template-columns: 1fr 4fr;
  grid-template-areas: "sidebar messages"
}
</style>