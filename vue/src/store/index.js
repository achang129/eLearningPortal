import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

/*
 * The authorization header is set for axios when you login but what happens when you come back or
 * the page is refreshed. When that happens you need to check for the token in local storage and if it
 * exists you should set the header so that it will be attached to each request
 */
const currentToken = localStorage.getItem('token')
const currentUser = JSON.parse(localStorage.getItem('user'));

if(currentToken != null) {
  axios.defaults.headers.common['Authorization'] = `Bearer ${currentToken}`;
}

export default new Vuex.Store({
  state: {
    token: currentToken || '',
    user: currentUser || {},
    courses: [],
    messages: [],
    activeCourse: {
      id: 0,
      name: '',
      homework: []
    },
    activeHomework: {
      id: null,
      courseId: null,
      title: ''
    },
    assignment: {
      title: '',
      description: '',
      questions: [
        {
          question: '',
          points: 10,
          answers: [
            {
              answer: '',
              isCorrect: false
            }
          ]
        }
      ]
    }
  },
  getters: {
    getRole: state => {
      return state.user.authorities[0]["name"]
    },
    assignment: ({assignment}) => assignment,
    assignmentArray: ({assignmentArray}) => assignmentArray,
    setAssignment: ({setAssignment}) => setAssignment
  },
  actions: {

  },
  mutations: {
    SET_AUTH_TOKEN(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
    },
    SET_USER(state, user) {
      state.user = user;
      localStorage.setItem('user',JSON.stringify(user));
    },
    LOGOUT(state) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      state.token = '';
      state.user = {};
      axios.defaults.headers.common = {};
    },
    SET_COURSES(state, data) {
      console.log(data);
      data.forEach((course)=>{state.courses.push(course);});
    },
    DELETE_COURSE(state, courseId) {
      state.courses = state.courses.filter((course) => {
        return course.id !== courseId;
      });
    },
    SET_ACTIVE_COURSE(state, data) {
      state.activeCourse = data;
    },
    DELETE_HOMEWORK(state, id) {
      state.activeCourse.homework.splice(
        state.activeCourse.homework.findIndex(homework => homework.id === id),
        1
      )
    },
    SET_ACTIVE_HOMEWORK(state, data) {
      state.activeHomework = data;
    },
    DELETE_MESSAGE(state, messageId) {
      state.messages = state.messages.filter((message) => {
        return message.id !== messageId;
      });
    },
    UPDATE_ASSIGNMENT_TITLE(state, info) {
      state.assignment.title = info.title;
    },
    UPDATE_ASSIGNMENT_DESC(state, info) {
      state.assignment.description = info.description;
    },
    ADD_ANSWER(state, question) {
      state.assignment.questions[question].answers.push({
        answer: '',
        isCorrect: false
      });
    },
    REMOVE_ANSWER(state, question, answer) {
      alert(question)
      alert(answer)
      if (state.assignment.questions[question].answers.length > 1) {
        state.assignment.questions[question].answers.splice(answer, 1);
      }
    },
    UPDATE_ANSWER_STATE(state, questionIndex, answerIndex) {
      if (state.assignment.questions[questionIndex].answers[answerIndex].isCorrect == false) {
        state.assignment.questions[questionIndex].answers[answerIndex].isCorrect = true;
      } else {
        state.assignment.questions[questionIndex].answers[answerIndex].isCorrect = false;
      }
    },
    UPDATE_ANSWER_TEXT(state, questionIndex, answerIndex, data) {
      const answerText = data.answer;
      const answer = state.assignment.questions[questionIndex].answers[answerIndex];
      answer.answer = answerText;
    },
    ADD_QUESTION(state) {
      state.assignment.questions.push({question: "", points: 10, answers:[]})
    },
    REMOVE_QUESTION(state, question) {
      if (state.assignment.questions.length > 1) {
        state.assignment.questions.splice(question, 1);
      }
    },
    UPDATE_QUESTION_TITLE(state, questionIndex) {
      const question = state.assignment.questions[questionIndex];
      question.question = question.title;
    },
    UPDATE_QUESTION_POINTS(state, questionIndex) {
      const question = state.assignment.questions[questionIndex];
      question.points = this.questions[questionIndex].points;
    },
    RESET_ASSIGNMENT(state) {
      state.assignment = {
        title: '',
        description: '',
        questions: [
        {
          question: '',
          points: 10,
          answers: [
          {
            answer: '',
            isCorrect: false
          }
          ]
        }
        ]
      }
    },
    SET_ASSIGNMENTS(state, data) {
      console.log(data);
      data.forEach((assignment)=>{state.assignments.push(assignment);});
    }
  }
})
