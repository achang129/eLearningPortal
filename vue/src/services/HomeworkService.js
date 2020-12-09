import axios from 'axios';

const http = axios.create({
    baseURL: "http://localhost:8080"
  });

export default{
    list() {
        return http.get('/homework');
    },
    addHomework(homework) {
        return http.post('/homework', homework);
    },

    get(homeworkId) {
        return http.get(`/homework/${homeworkId}`)
    },
    submitHomework(homework) {
        return http.post(`/homework/${homework.id}`, homework);
    },
    updateHomework(homework) {
        return http.put(`/homework/${homework.id}`, homework);
    },
    deleteHomework(homeworkId) {
        return http.delete(`/homework/${homeworkId}`);
    }
}