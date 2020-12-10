import axios from 'axios';

const http = axios.create({
    baseURL: "http://localhost:8080"
  });

export default{
    list() {
        return http.get('/messages');
    },
    get(messageId) {
        return http.get(`/messages/${messageId}`)
    },
    updateMessage(message) {
        return http.put(`/messages/${message.id}`, message);
    },
    deleteMessage(messageId) {
        return http.delete(`/messages/${messageId}`);
    }
}