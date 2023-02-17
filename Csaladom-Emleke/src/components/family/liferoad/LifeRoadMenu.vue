<template>

    <div>
        <liferoads v-if="VanNeki" />
        <newliferoad v-else />
    </div>

</template>

<script>

import liferoads from '../liferoad/LifeRoads.vue'
import newliferoad from '../liferoad/NewLifeRoad.vue'
import axios from "axios";

export default{
    components:{
      liferoads,
      newliferoad,
    },

data(){
    return {
        felhasznalo: [],
        VanNeki : true // Ha van a felhasználónak felvitt adata!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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