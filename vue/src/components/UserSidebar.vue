<template>
    <div class="user-sidebar">
        <ul id="primary-nav" class="flex-container">
            <br>
            <router-link class="head-link" v-bind:to="{ name: 'home' }">Home</router-link>
            &nbsp;_______&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'messages' }">Messages</router-link>
            &nbsp;_______&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'all-courses' }">Courses</router-link>
            &nbsp;_______&nbsp;
            <router-link class="head-link" v-bind:to="{ name: 'all-homework' }">Homework</router-link>
            &nbsp;_______&nbsp;
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

<style>
.flex-container{
    display:flex;
    justify-content:center;
    align-items:center;
}

.user-sidebar #primary-nav{
    
    border: 5px solid black;
    border-radius: 2%;
    border-style: solid;
    font: 16px/3 helvetica, arial, sans-serif;
    background-color: rgb(155, 180, 202);
    
    display: flex;
    flex-direction: column;
    width: fit-content;
    align-content: center;
    padding-right: 25px;
    justify-content: space-evenly;
    
}
.head-link{
    font-weight: bolder;
    text-decoration: none;
    display: flex;
    align-content: center;
    justify-content: center;
    color: rgb(87, 42, 192);
    background-color: rgb(155, 180, 202);
}

.head-link:hover {
    text-decoration: underline;
}
</style>