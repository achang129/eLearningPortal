<template>
    <div>
        
    </div>
</template>

<script>
import HomeworkService from '../services/HomeworkService';
import GradeView from '../components/GradeView.vue';

export default {
  name: "student-work-list",
  props: ["id"],
  data() {
    return {
        assignments: []
    }
  },
  computed: {},
  methods: {
  }
};

</script>