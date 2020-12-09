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

//CURRICULUM  . .  displays details of a selected course
import Curriculum from '../views/Curriculum.vue'
//curricula is landing page for somebody to see all their courses
import Curricula from '../views/Curricula.vue'
import CreateCurriculum from '../views/CreateCurriculum.vue'
import EditCurriculum from '../views/EditCurriculum.vue'

//HOMEWORKList displays all upcoming homework
import HomeworkList from '../views/HomeworkList.vue'
import CreateHomework from '../views/CreateHomework.vue'
import EditHomework from '../views/EditHomework.vue'
//HOMEWORK displays specific assignment by ID
import Homework from '../views/Homework.vue'


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
        requiresAuth: false
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
    //Course will route to all of the student's or teacher's courses (maybe two separate components
    // with a v-if type thing, this concept could be extended to most of the views, really)
    {
      path: "/course",
      name: "curricula",
      component: Curricula,
      meta: {
        requiresAuth: false
        //TRUE
      }
    },
    //Keep in mind that, if course/create were below course/:id, it would parse "create" as the id, and send
    //to curriculum page, not create page
    {
      path: '/course/create',
      name: 'create-curriculum',
      component: CreateCurriculum,
      meta: {
        requiresAuth: false
        //TRUE
      }
    },
    {
      path: '/course/:id',
      name: 'curriculum',
      component: Curriculum,
      props(route) {
        const props = {...route.params}
        props.id = Number(props.id)
        return props
      },
      meta: {
        requiresAuth: false
        //TRUE
      }
    },
    {
      path: '/course/:id/edit',
      name: 'edit-curriculum',
      component: EditCurriculum,
      meta: {
        requiresAuth: false
        //TRUE
      }
    },
    {
      path: '/homework',
      name: 'homework-list',
      component: HomeworkList,
      meta: {
        requiresAuth: false
        //TRUE
      }
    },
    {
      path: '/homework/create',
      name: 'create-homework',
      component: CreateHomework,
      meta: {
        requiresAuth: false
        //TRUE
      }
    },
    {
      path: '/homework/:id',
      name: 'homework',
      component: Homework,
      meta: {
        requiresAuth: false
        //TRUE
      }
    },
    {
      path: '/homework/:id/edit',
      name: 'edit-homework',
      component: EditHomework,
      meta: {
        requiresAuth: false
        //TRUE
      }
    },
    {
      path: '/messages',
      name: 'messages',
      component: Messages,
      meta: {
        requiresAuth: false
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
