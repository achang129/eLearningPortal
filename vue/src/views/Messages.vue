<template>
  <div id="messages-view-page">
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

export default {
  components: {UserSidebar, MessageNotifications},
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
  border-color: #e6c2bf;
  border-radius: 24px;
  height: 17rem;
  width: 70%;
}

#messages-notifications-container {
  grid-area: messages;
}
#messages-page-sidebar {
  grid-area: sidebar;
}

#messages-view-page {
  display: grid;
  grid-template-columns: 1fr 4fr;
  grid-template-areas:
  "header header"
  "sidebar messages";
}
</style>