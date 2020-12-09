<template>
    <div class="progress">
        <div class="bar" :style="'height:30px;background:blue;width:' + progress() + '%'"></div>
        <div>{{ progress() }}% Completed</div>
    </div>
</template>

<script>
export default {
    name: 'progress-bar',
    data() {
        return {
            completed: 5,
            total: 10
        }
    },
    methods: {
        progress(){
            return this.completed / this.total * 100
        }
    }
}
</script>