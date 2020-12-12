import Vue from 'vue'
import Router from 'vue-router'
import store from '../store/index'
import Home from '../views/Home.vue'

//LOGIN COMPONENTS
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'

//ACCOUNT FEATURES/DETAILS
import Messages from '../views/Messages.vue'
import NotFound from '../views/NotFound.vue'

//COURSE Related Components 
import Course from '../views/Course.vue'
import AllCourses from '../views/AllCourses.vue'
import CreateCourse from '../views/CreateCourse.vue'
import EditCourse from '../views/EditCourse.vue'

//HOMEWORK
import Homework from '../views/Homework.vue'
import AllHomework from '../views/AllHomework.vue'
import CreateHomework from '../views/CreateHomework.vue'
import EditHomework from '../views/EditHomework.vue'


Vue.use(Router)

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    //temporarily changing all "requiresAuth" to false. commented original value underneath.
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: {
        requiresAuth: true
        //TRUE
      }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresAuth: false
        //FALSE
      }
    },
    {
      path: "/logout",
      name: "logout",
      component: Logout,
      meta: {
        requiresAuth: false
        //FALSE
      }
    },
    {
      path: "/register",
      name: "register",
      component: Register,
      meta: {
        requiresAuth: false
        //FALSE
      }
    },
    //Courses will route to all of the student's or teacher's courses (maybe two separate components
    // with a v-if type thing, this concept could be extended to most of the views, really)
    {
      path: "/courses",
      name: "all-courses",
      component: AllCourses,
      meta: {
        requiresAuth: true
        //TRUE
      }
    },
    //Keep in mind that, if courses/create were below courses/:id, it would parse "create" as the id, and send
    //to curriculum page, not create page
    {
      path: '/courses/create',
      name: 'create-course',
      component: CreateCourse,
      meta: {
        requiresAuth: true
        //TRUE
      }
    },
    {
      path: '/courses/:id',
      name: 'course',
      component: Course,
      meta: {
        requiresAuth: true
        //TRUE
      }
    },
    {
      path: '/courses/:id/edit',
      name: 'edit-course',
      component: EditCourse,
      meta: {
        requiresAuth: true
        //TRUE
      }
    },
    {
      path: '/homework',
      name: 'all-homework',
      component: AllHomework,
      meta: {
        requiresAuth: true
        //TRUE
      }
    },
    {
      path: 'courses/:id/homework/create',
      name: 'create-homework',
      component: CreateHomework,
      meta: {
        requiresAuth: true
        //TRUE
      }
    },
    {
      path: 'courses/:id/homework/:hwId',
      name: 'homework',
      component: Homework,
      meta: {
        requiresAuth: true
        //TRUE
      }
    },
    {
      path: 'courses/:id/homework/:hwId/edit',
      name: 'edit-homework',
      component: EditHomework,
      meta: {
        requiresAuth: true
        //TRUE
      }
    },
    {
      path: '/messages',
      name: 'messages',
      component: Messages,
      meta: {
        requiresAuth: true
        //TRUE
      }
    },
    //TODO: specific error components (lack permission, homework or course creation error, ... etc)
    {
      path: '/error',
      name: 'error',
      component: NotFound
    },
    //any undefined url
    {
      path: '/**',
      name: 'not-found',
      component: NotFound
    }
  ]
})

router.beforeEach((to, from, next) => {
  // Determine if the route requires Authentication
  const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

  // If it does and they are not logged in, send the user to "/login"
  if (requiresAuth && store.state.token === '') {
    next("/login");
  } else {
    // Else let them go to their next destination
    next();
  }
});

export default router;
