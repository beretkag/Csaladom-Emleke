<template>
    <button class="btn btn-primary visszagomb rounded-circle"><i class="bi bi-arrow-left"></i></button>
    <header class="row">
        <img class="col-lg-4 col-md-3 kep m-3 p-0" src="../assets/Profilkepteszt.png" alt="felhasznalo profilkep">
        <h2 class="col-lg-6 col-md-5 col-xs-4 d-flex justify-content-center flex-column">Becses fiam</h2>
        <div class="col-lg-2 col-md-4 col-xs-4 d-flex justify-content-end flex-column"><button class="btn btn-primary">Új paragrafus írása</button></div>
    </header>
    <hr>
    <main>
        <div class="m-3">
            <div class="row">
                <h3 class="col-10">CIMECSKE</h3>
                <div class="col-2 d-flex flex-row-reverse">    
                    <button class="m-1 m-lg-2 m-sm-1 btn btn-danger"><i class="bi bi-trash"></i></button>
                    <button class="m-1 m-lg-2 m-sm-1 btn btn-warning"><i class="bi bi-pencil"></i></button>
                </div>
            </div>
            <p class="m-3">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Illo aliquam aliquid soluta quam qui tenetur non dolore cupiditate quos voluptates. Voluptate alias consequatur minus fugiat unde similique! Ut, harum dolorem?</p>
            <hr>
        </div>
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
    object-fit: cover;
}
@media all and (max-width:768px) {

img {
    width: 24vw !important;
    height: 24vw !important;
    margin-right: auto !important;
    margin-left: auto !important;
}
h2{
    text-align: center;
    text-decoration: underline;
}
}
.visszagomb{
    position: absolute;
    top: 15px;
    right: 15px;
    z-index: 999;
}
p{
    text-indent: 35px;
    text-align: justify;
}


</style>