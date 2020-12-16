<template>
    <div class="progress">
        <span :style="'width:' + calculateGrade() + '%'"></span>
        <h3 class="progresstext">Total Progress {{ calculateGrade() }}%</h3>
    </div>
</template>

<script>
import gradeService from '../services/GradeService'

export default {
    name: 'progress-bar',
    data() {
        return {
            grades: [],
            cummulative: 0
        }
    },
    methods: {
        getGrades() {
            gradeService.list()
            .then(response => {
                this.grades = response.data;
            });
        },
        calculateGrade() {
            let combined = 0
            let numOfGrades = 0
            for (var grade in this.grades) {
                combined += Number(this.grades[grade].grade);
                numOfGrades += 1;
            }
            this.cummulative = 100 * (combined / numOfGrades);
            if ((this.cummulative).isNAN) {
                return 0;
            }
            return this.cummulative;
        }
    },
    created() {
        this.getGrades();
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