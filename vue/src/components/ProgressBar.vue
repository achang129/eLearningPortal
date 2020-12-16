<template>
    <div class="progress">
        <span :style="'width:' + calculateGrade() + '%'"></span>
        <h3 class="progresstext">{{ calculateGrade() }}%</h3>
    </div>
</template>

<script>
import gradeService from '../services/GradeService'

export default {
    name: 'progress-bar',
    data() {
        return {
            grades: gradeService.list(),
            value: 0,
            earned: 0,
            total: 0,
            cummulative: 0
        }
    },
    methods: {
        calculateGrade() {
            var earned = 0;
            var total = 0;
            for (var grade in this.grades) {
                earned += Number(this.grades[grade].earned);
                total += Number(this.grades[grade].total);
            }
            this.earned = earned;
            this.total = total;
            this.cummulative = 100 * (earned / total);
            this.cummulative = this.cummulative.toFixed(2);
            if ((this.cummulative).isNAN) {
                return 0;
            }
            return this.cummulative;
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