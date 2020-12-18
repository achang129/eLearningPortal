<template>
    <div class="user-sidebar">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.13.0/css/all.css">
        <ul id="primary-nav" class="flex-container">
            <br>
            <router-link class="head-icon" v-bind:to="{ name: 'home' }"><i class="fas fa-home fa-3x" data-fa-mask="fas fa-square" ></i></router-link>
            <router-link class="head-link" v-bind:to="{ name: 'home' }">Home</router-link>
            
            <router-link v-if='$store.state.user.authorities[0]["name"]=="ROLE_OVERLORD"' class="head-icon" v-bind:to="{ name: 'messages' }"><i class="fas fa-envelope fa-3x" data-fa-mask="fas fa-square"></i></router-link>
            <router-link v-if='$store.state.user.authorities[0]["name"]=="ROLE_OVERLORD"' class="head-link" v-bind:to="{ name: 'messages' }">Messages</router-link>
            
            <router-link class="head-icon" v-bind:to="{ name: 'all-courses' }"><i class="fas fa-chalkboard fa-3x" data-fa-mask="fas fa-square" ></i></router-link>
            <router-link class="head-link" v-bind:to="{ name: 'all-courses' }">Courses</router-link>
            
            <router-link v-if='$store.state.user.authorities[0]["name"]=="ROLE_USER"' class="head-icon" v-bind:to="{ name: 'all-homework' }"><i class="fas fa-book-open fa-3x" data-fa-mask="fas fa-square" ></i></router-link>
            <router-link v-if='$store.state.user.authorities[0]["name"]=="ROLE_USER"' class="head-link" v-bind:to="{ name: 'all-homework' }">Homework</router-link>

            <router-link v-if='$store.state.user.authorities[0]["name"]=="ROLE_ADMIN" || $store.state.user.authorities[0]["name"]=="ROLE_TEACHER"' class="head-icon" v-bind:to="{ name: 'main-dashboard' }"><i class="fas fa-book-open fa-3x" data-fa-mask="fas fa-square"></i></router-link>
            <router-link v-if='$store.state.user.authorities[0]["name"]=="ROLE_ADMIN" || $store.state.user.authorities[0]["name"]=="ROLE_TEACHER"' class="head-link" v-bind:to="{ name: 'main-dashboard' }">Dashboard</router-link>

            <!-- <router-link v-if='$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"' class="head-icon" v-bind:to="{ name: 'main-dashboard' }"><i class="fas fa-book-open fa-3x" data-fa-mask="fas fa-square" style="background:rgb(155, 180, 202)"></i></router-link>
            <router-link v-if='$store.state.user.authorities[0]["name"]=="ROLE_TEACHER"' class="head-link" v-bind:to="{ name: 'main-dashboard' }">Student Dashboard</router-link> -->
            
            <router-link class="head-icon" v-bind:to="{ name: 'logout' }"><i class="fas fa-sign-out-alt fa-3x" data-fa-mask="fas fa-square" ></i></router-link>
            <router-link class="head-link" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
            <br>
        </ul>
        
    </div>
</template>

<script>
//The intent is for this to help us navigate the page quickly while designing, the final header will have more
//logical links

export default {
    name: "user-sidebar"
}
</script>

<style scoped>
.flex-container{
    
    display:flex;
    justify-content:center;
    align-items:center;
}

.user-sidebar #primary-nav{
    
    /* border: 5px solid black;
    border-radius: 2%;
    border-style: solid; */
    font: 16px/3 helvetica, arial, sans-serif;
    /* background-color: rgb(155, 180, 202); */
    display: flex;
    flex-direction: column;
    width: 60%;
    
    align-content: center;
    padding-right: 35px;
    justify-content: space-evenly;
    
}
.head-link{
    font-weight: bolder;
    text-decoration: none;
    display: flex;
    align-content: center;
    justify-content: center;
    color:rgb(38, 62, 82);
    /* background-color: rgb(155, 180, 202); */
}

.head-link:not(:nth-last-of-type(1)) {
	border-bottom: 1px solid black;
}

.head-link:hover {
    text-decoration: underline;
}

.head-icon{
    font-weight: bolder;
    text-decoration: none;
    display: flex;
    align-content: center;
    justify-content: center;
    color: rgb(38, 62, 82);
    /* background-color: rgb(155, 180, 202); */
    padding-top: 15px;
}
</style>