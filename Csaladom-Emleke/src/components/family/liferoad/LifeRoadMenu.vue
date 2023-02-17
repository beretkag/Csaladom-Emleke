<template>

    <div>
        <liferoad v-if="VanNeki" />
        <newliferoad v-else />
    </div>

</template>

<script>

import liferoad from '../liferoad/LifeRoad.vue'
import newliferoad from '../liferoad/NewLifeRoad.vue'
import axios from "axios";

export default{
data(){
    return {
        felhasznalo: []
           }
      },
   
created(){
    
    axios.get(this.$store.getters.baseURL + "/eletut" + id).then(res => {
        let data = res.data;
            this.felhasznalok = res.data 
    })
    .catch(err => {
        console.log(err);
    })
}
}

</script>

<style>

</style>