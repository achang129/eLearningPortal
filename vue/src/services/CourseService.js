import axios from 'axios';

const http = axios.create({
    baseURL: "http://localhost:8080"
});

export default{
    list() {
        return http.get('/courses/all');
    },
    listTeachers() {
        return http.get('/users/teacher');
    },
    listStudents() {
        return http.get('/users/user');
    },
    listAssignedStudents(id){
        return http.get(`/enrollment/${id}/user`);
    },
    listAssignedTeachers(id){
        return http.get(`/enrollment/${id}/teacher`);
    },
    assignToCourse(course, users){
        users.forEach((user)=>{
            let assignment = {
                'course': course,
                'user': user
            };
            http.put('/courses', assignment);
        });
    },
    removeFromCourse(course, users){
        users.forEach((user)=>{
            let assignment = {
                'course': course,
                'user': user
            };
            http.put('/courses/remove', assignment);
        });
    },
    addCourse(course) {
        return http.post('/courses', course);
    },
    updateCourse(course) {
        return http.put(`/courses/${course.id}`, course);
    },
    getCoursework(courseId) {
        return http.get(`/courses/${courseId}`);
    },
    addCurriculum(course, lesson, date) {
        let curriculum = {lesson: lesson, date: date};
        return http.post(`/courses/${course}`, curriculum);
    },
    updateCurriculum(course, curriculum, date) {
        return http.put(`/courses/${course.id}`, course, curriculum, date);
    },
    deleteCourse(courseId) {
        return http.delete(`/courses/${courseId}`);
    },
    getAllGradesForCourse(id) {
        return http.get(`/courses/grade/${id}`);
    },
    getAllGPAs(){
        return http.get(`/student`);
    }
}