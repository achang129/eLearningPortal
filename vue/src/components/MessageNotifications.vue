<template>
    <div class="message-notifications">
      
    <div v-for="message in this.$store.state.messages" v-bind:key="message.id" class="message bubble" >
      <h3>{{ message.title }}</h3>
      <p>{{ message.messageText }}</p>
      <button v-on:click="deleteMessage(message.id)">Delete</button>
    </div>
  </div>
</template>

<script>
import messageService from "../services/MessageService.js";

export default {
  name: "message-notifications",
  data() {
    return {
      errorMsg: "",
      messages: []
    }
  },
  methods: {
    makeMessageList() {
      messageService.list().then(response => {
        response.data.forEach((message)=>{this.messages.push(message);});
      });
    },
    deleteMessage(id) {
      messageService.deleteMessage(id)
        .then(response => {
          if (response.status === 200) {
            this.messages = this.messages.filter((message)=>{return message.id !== id;});
          }
        }).catch(error => {
          if (error.response) {
            this.errorMsg = error.response.statusText;
          }
        });
    }
  },
  created() {
    this.makeMessageList();
  }
}
</script>

<style scoped>
.message-notifications {
  padding: 20px 20px;
  margin: 0 auto;
  max-width: 600px;
}

.bubble {
  box-sizing: border-box;
  width: auto;
  position: relative;
  clear: both;

  background: #95c2fd;
  background-image: -webkit-gradient(
    linear,
    left bottom,
    left top,
    color-stop(0.15, #bee2ff),
    color-stop(1, #95c2fd)
  );
  background-image: -webkit-linear-gradient(bottom, #bee2ff 15%, #95c2fd 100%);
  background-image: -moz-linear-gradient(bottom, #bee2ff 15%, #95c2fd 100%);
  background-image: -ms-linear-gradient(bottom, #bee2ff 15%, #95c2fd 100%);
  background-image: -o-linear-gradient(bottom, #bee2ff 15%, #95c2fd 100%);
  background-image: linear-gradient(to top, #bee2ff 15%, #95c2fd 100%);
  filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#95c2fd', endColorstr='#bee2ff');

  border: solid 1px rgba(0, 0, 0, 0.5);
  -webkit-border-radius: 20px;
  -moz-border-radius: 20px;
  border-radius: 20px;

  -webkit-box-shadow: inset 0 8px 5px rgba(255, 255, 255, 0.65),
    0 1px 2px rgba(0, 0, 0, 0.2);
  -moz-box-shadow: inset 0 8px 5px rgba(255, 255, 255, 0.65),
    0 1px 2px rgba(0, 0, 0, 0.2);
  box-shadow: inset 0 8px 5px rgba(255, 255, 255, 0.65),
    0 1px 2px rgba(0, 0, 0, 0.2);
  margin-bottom: 20px;
  padding: 6px 20px;
  color: #000;
  text-shadow: 0 1px 1px rgba(255, 255, 255, 0.8);
  word-wrap: break-word;
}
</style>