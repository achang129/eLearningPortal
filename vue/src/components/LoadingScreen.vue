<template>
    <div class="loading">
        <img src="../assets/correctLoading.gif" />
    </div>
</template>

<script>
export default {
    name: 'loading-screen',
}
</script>

<style>
 .loading {
    display: flex;
    align-items: center;
    align-content: center;
    justify-content: center;
    align-self: center;
    height: 100vh;
} 
.loading img{
    border:groove black;
}
</style>