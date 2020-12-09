import axios from 'axios';

const http = axios.create({
    baseURL: "http://localhost:8080"
  });

export default{
    list() {
        return http.get('/courses');
    },
    addCourse(course) {
        return http.post('/courses', course);
    },
    updateCourse(course) {
        return http.put(`/courses/${course.id}`, course);
      },

    get(courseId) {
        return http.get(`/courses/${courseId}`);
    },
    addCurriculum(course, curriculum, date) {
        return http.post(`/courses/${course.id}`, course, curriculum, date);
    },
    updateCurriculum(course, curriculum, date) {
        return http.put(`/courses/${course.id}`, course, curriculum, date);
    },
    deleteCourse(courseId) {
        return http.delete(`/courses/${courseId}`);
    }
}