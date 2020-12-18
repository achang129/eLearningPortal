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
    updateGrade(user, homework, grade, comment) {
        return http.put(`/grades/${homework}`, {'student':user, 'grade':grade, 'comment':comment});
    }
}