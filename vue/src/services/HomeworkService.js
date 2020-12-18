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
    submitted(id){
      return http.get(`/homework/${id}/status`)  
    },
    submitHomework(id) {
        return http.post(`/homework/${id}`);
    },
    saveHomeworkProgress(id, q, a) {
        return http.put(`/homework/${id}`, {'question':q, 'answer':a});
    },
    deleteHomework(homeworkId) {
        return http.delete(`/homework/${homeworkId}`);
    },
    getStudentWork(student, course){
        return http.get(`/grades/${course}/${student}`);
    }
}