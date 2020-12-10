<template>
    <div class="login-register-header">
        <router-link class="login-reg-link" v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''">Login</router-link> /
        <router-link class="login-reg-link" v-bind:to="{ name: 'register' }" v-if="$store.state.token == ''">Register</router-link>
    </div>
</template>

<script>
export default {
    name: "login-register-header"
}
</script>

<style>
.login-register-header{
    display: flex;
    flex-direction: row;
    justify-content: center;
    font-size: 30px;
}

.login-reg-link {
    text-decoration: none;
}

.login-reg-link:hover{
    text-decoration: underline;
}

</style>