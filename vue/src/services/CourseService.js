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
    listUnchosenStudents(courseId){
        return http.get(`/users/user/${courseId}`);
    },
    listUnchosenTeachers(courseId){
        return http.get(`/users/teacher/${courseId}`);
    },
    listEnrolledStudents(courseId){
        return http.get(`${courseId}/enrolled/user`);
    },
    listEnrolledTeachers(courseId){
        return http.get(`${courseId}/enrolled/teacher`);
    },
    addTeacherToCourse(course, teachers){
        teachers.forEach((teacher)=>{
            let assignment = {
                'course': course,
                'user': teacher
            };
            http.put('/courses', assignment);
        });
    },
    addStudentsToCourse(course, students){
        students.forEach((student)=>{
            let assignment = {
                'course': course,
                'user': student
            };
            http.put('/courses', assignment);
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
    }
}