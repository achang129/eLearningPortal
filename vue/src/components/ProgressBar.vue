<template>
    <div class="progress">
        <span :style="'width:' + calculateGrade() + '%'"></span>
        <div class="prog-bar-text">
            <h3>Total Progress {{ calculateGrade() }}%</h3>
        </div>
        
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
                console.log(response.data);
                this.grades = response.data;
            });
        },
        calculateGrade() {
            
            let combined = 0
            let numOfGrades = 0
            if(this.grades.length==0){
                this.cummulative = 0;
                return this.cummulative;
            }
            for (var grade in this.grades) {
                combined += Number(this.grades[grade].grade);
                numOfGrades += 1;
            }
            this.cummulative = 100 * (combined / numOfGrades);
            if ((this.cummulative).isNAN) {
                this.cummulative = 0;
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
.prog-bar-text{
    text-align: center;
    margin-top: 10px;
}

.progress { 
    
    height: 20px;
    width: auto;
	background-color:#3a3535;
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
  background-color:rgb(175, 198, 216);
  position: relative;
  overflow: hidden;
}
</style>