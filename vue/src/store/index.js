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
    activeCourse: {
      id: 0,
      name: '',
      homework: []
    },
    activeHomework: {
      id: null,
      courseId: null,
      title: ''
    }
  },
  getters: {
    
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
    }
  }
})
