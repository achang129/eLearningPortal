<template>
    <div class="progress">
        <span :style="'width:' + progress() + '%'"></span>
        <h3 class="progresstext">{{ progress() }}% completed</h3>
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

<style scoped>
.progresstext{
    text-align: center;
}

.progress { 
    
    height: 20px;
    width: auto;
	
	background: grey;
	border-radius: 25px;
	padding: 10px;
    margin-right: 15px;
}
.progress > span {
  display: block;
  height: 100%;
  border-top-right-radius: 8px;
  border-bottom-right-radius: 8px;
  border-top-left-radius: 20px;
  border-bottom-left-radius: 20px;
  background-color: blue;
  position: relative;
  overflow: hidden;
}
</style>