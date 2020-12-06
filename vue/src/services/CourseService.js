import axios from 'axios';

const http = axios.create({
    baseURL: "http://localhost:5432/final_capstone"
  });

export default{
    list() {
        return http.get('/curricula');
    },
    get(courseId) {
        return http.get(`/curricula/${courseId}`)
    }
}