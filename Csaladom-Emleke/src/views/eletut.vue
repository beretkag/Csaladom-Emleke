<template>
    <header class="row">
        <img class="col-4 kep m-3" src="../assets/Nopic.png" alt="felhasznalo profilkep">
        <div class="col-2 offset-6 d-flex justify-content-end flex-column"><button class="btn btn-primary">Új paragrafus írása</button></div>
    </header>
    <hr>
    <main>
        
    </main>
</template>
<script>
import axios from 'axios';

export default{
    props:{
        nodeid:String

    },
    data(){
        return{
            node:{},
            paragraphs:[],
        }
    },
    created(){
        axios.get(this.$store.getters.baseURL+"/csaladtagok/ID/"+this.nodeid)
        .then(res=>{
            this.node=res.data[0]
            console.log(res.data)
            axios.get(this.$store.getters.baseURL+"/eletut/csaladtagID/"+this.nodeid)
            .then(res=>{
                this.paragraphs=res.data;
            })
        })
        
    },
    methods:{
        
    }

}
</script>
<style scoped>
.kep{
    width: 18vw;
    height: 18vw;
    border-radius: 50%;
    border: 2px solid black;
}


</style>