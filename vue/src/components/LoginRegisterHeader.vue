<template>
    <div class="login-register-header">
        <router-link class="head-link" v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''">Login</router-link>
        <router-link class="head-link" v-bind:to="{ name: 'register' }" v-if="$store.state.token == ''">Register</router-link>
    </div>
</template>

<script>
export default {
    name: "login-register-header"
}
</script>

<style>
.login-register-header{
    display:inline-block;
}

</style>