<template>
    <div class="dev-header">
        <ul id="primary-nav">
            &nbsp;|&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'home' }">Home</router-link>
            <e v-if="$store.state.token == ''">&nbsp;|&nbsp;</e>            
            <router-link class="head-link" v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''">Login</router-link>
            <e v-if="$store.state.token == ''">&nbsp;|&nbsp;</e>
            <router-link class="head-link" v-bind:to="{ name: 'register' }" v-if="$store.state.token == ''">Register</router-link>&nbsp;|&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
            <e v-if="$store.state.token != ''">&nbsp;|&nbsp;</e>
            <router-link class="head-link" v-bind:to="{ name: 'curricula' }">My Courses!</router-link>&nbsp;|&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'homework-list' }">All Upcoming Homework</router-link>&nbsp;|&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'messages' }">Messages and Notifications</router-link>&nbsp;|&nbsp;
        </ul>
        <router-view />
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
    border-style: double;
    color: aliceblue;
    font: 16px/3 helvetica, arial, sans-serif;
    background-color: rgb(155, 180, 202);
    margin: 10 10 10 10;
    display: flex;
    justify-content: space-evenly;
}
.head-link{
    color: rgb(129, 76, 12);
}
</style>