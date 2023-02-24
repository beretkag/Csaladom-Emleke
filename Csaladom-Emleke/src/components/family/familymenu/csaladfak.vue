<template>

 <ul>
    <li v-for="csaladfa in csaladfak">
         {{ csaladfa.Nev }}
    </li>
 </ul>

</template>

<script>
import axios from 'axios';

 export default{
    components: {
      axios
    },
    data(){
       return{
          csaladfak: []
       }
    },
    created(){
  axios.get(this.$store.getters.baseURL + "/csaladfak").then(res => {
    let data = res.data;
    this.csaladfak = res.data 
  })
  .catch(err => {
    console.log(err);
  });
}

 }

</script>

<style>

</style>