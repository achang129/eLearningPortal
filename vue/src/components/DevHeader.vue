<template>
    <div class="dev-header">
        <ul id="primary-nav">
            &nbsp;&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;______________________&nbsp;
            <!-- <e v-if="$store.state.token == ''">&nbsp;_______&nbsp;</e>             -->
            <router-link class="head-link" v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''">Login</router-link>&nbsp;______________________&nbsp;
            <!-- <e v-if="$store.state.token == ''">&nbsp;_______&nbsp;</e> -->
            <router-link class="head-link" v-bind:to="{ name: 'register' }" v-if="$store.state.token == ''">Register</router-link>&nbsp;______________________&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
            <!-- <e v-if="$store.state.token != ''">&nbsp;_______&nbsp;</e> -->
            <router-link class="head-link" v-bind:to="{ name: 'curricula' }">My Courses!</router-link>&nbsp;______________________&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'homework-list' }">All Upcoming Homework</router-link>&nbsp;______________________&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'messages' }">Messages and Notifications</router-link>&nbsp;&nbsp;
        </ul>
        
    </div>
</template>

<script>
//The intent is for this to help us navigate the page quickly while designing, the final header will have more
//logical links

export default {
    name: "dev-header"
}
</script>

<style>


.dev-header #primary-nav{
    
    border: 5px solid black;
    border-radius: 2%;
    border-style: solid;
    font: 16px/3 helvetica, arial, sans-serif;
    background-color: rgb(155, 180, 202);
    
    display: flex;
    flex-direction: column;
    width: fit-content;
    padding-right: 25px;
    justify-content: space-evenly;
    
}
.head-link{
    font-weight: bolder;
    text-decoration: none;
    display: flex;
    justify-content: center;
    color: rgb(87, 42, 192);
    background-color: rgb(155, 180, 202);
}

.head-link:hover {
    text-decoration: underline;
}
</style>