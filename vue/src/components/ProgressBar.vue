<template>
    <div class="progress">
        <div class="bar" :style="'height:30px;background:blue;width:' + progress + '%'"></div>
    </div>
</template>

<script>
export default {
    methods: {
        progress(){
            return this.completed / this.total * 100
        }
    }
}
</script>