<template>
    <div class="dev-header">
        <ul id="primary-nav">
            &nbsp;&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;_____________&nbsp;
            <!-- <e v-if="$store.state.token == ''">&nbsp;_______&nbsp;</e>             -->
            <router-link class="head-link" v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''">Login</router-link>&nbsp;_____________&nbsp;
            <!-- <e v-if="$store.state.token == ''">&nbsp;_______&nbsp;</e> -->
            <router-link class="head-link" v-bind:to="{ name: 'register' }" v-if="$store.state.token == ''">Register</router-link>&nbsp;_____________&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
            <!-- <e v-if="$store.state.token != ''">&nbsp;_______&nbsp;</e> -->
            <router-link class="head-link" v-bind:to="{ name: 'curricula' }">My Courses!</router-link>&nbsp;_____________&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'homework-list' }">All Upcoming Homework</router-link>&nbsp;_____________&nbsp;
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
    border-style: double;
    font: 16px/3 helvetica, arial, sans-serif;
    background-color: rgb(155, 180, 202);
    margin: 10 10 10 10;
    display: flex;
    flex-direction: column;
    width: 14em;
    
    justify-content: space-evenly;
    
}
.head-link{
    display: flex;
    justify-content: flex-start;
    color: rgb(87, 42, 192);
    background-color: rgb(155, 180, 202);
}
</style>