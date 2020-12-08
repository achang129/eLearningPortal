import axios from 'axios';

const http = axios.create({
    baseURL: "http://localhost:3000"
  });

export default{
    list() {
        return http.get('/course');
    },
    addCourse(course) {
        return http.post('/course', course);
    },
    updateCourse(course) {
        return http.put(`/course/${course.id}`, course);
      },

    get(courseId) {
        return http.get(`/course/${courseId}`);
    },
    addCurriculum(course, curriculum, date) {
        return http.post(`/course/${course.id}`, course, curriculum, date);
    },
    updateCurriculum(course, curriculum, date) {
        return http.put(`/course/${course.id}`, course, curriculum, date);
    },
    deleteCourse(courseId) {
        return http.delete(`/course/${courseId}`);
    }
}