import axios from 'axios';

const http = axios.create({
    baseURL: "http://localhost:8080"
});

export default{
    list() {
        return http.get('/grades');
    },
    get(homeworkId) {
        return http.get(`/grades/${homeworkId}`)
    },
    updateGrade(homework, grade) {
        return http.put(`/grades/${homework.id}`, grade);
    }
}