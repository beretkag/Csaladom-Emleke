<template>
    <button class="btn btn-primary visszagomb rounded-circle" @click="Vissza()"><i class="bi bi-arrow-left"></i></button>
    <header class="row">
        <img class="col-lg-4 col-md-3 kep m-3 p-0" src="../assets/Profilkepteszt.png" alt="felhasznalo profilkep">
        <h2 class="col-lg-6 col-md-5 col-xs-4 d-flex justify-content-center flex-column">{{ node.vezeteknev+" "+node.keresztnev }}</h2>
        <div class="col-lg-2 col-md-4 col-xs-4 d-flex justify-content-end flex-column" @click="UjParagrafus()"><button class="btn btn-primary">Új paragrafus írása</button></div>
    </header>
    <hr>
    <main>
        <div class="m-3" v-for="paragraph, index in paragraphs">
            <div class="row">
                <input v-if="paragraph.edit" type="text" class="form-control col-10"  placeholder="Cím" v-model="para">
                <h3 class="col-10" v-else >{{ paragraph.cim }}</h3>
                <div class="col-2 d-flex flex-row-reverse">    
                    <button v-if="paragraph.edit" class="m-1 m-lg-2 m-sm-1 btn btn-danger" @click="Megse(paragraph)"><i class="bi bi-x-lg"></i></button>
                    <button v-else class="m-1 m-lg-2 m-sm-1 btn btn-danger" @click="Torles(paragraph)"><i class="bi bi-trash"></i></button>
                    <button v-if="paragraph.edit" class="m-1 m-lg-2 m-sm-1 btn btn-warning" @click="SzerekesztesVeglegesites(paragraph)"><i class="bi bi-check-lg"></i></button>
                    <button v-else class="m-1 m-lg-2 m-sm-1 btn btn-warning" @click="Szerekesztes(paragraph)"><i class="bi bi-pencil"></i></button>
                </div>
            </div>
            <textarea v-if="paragraph.edit" class="form-control m-3" aria-label="With textarea"></textarea>
            <p v-else class="m-3">{{ paragraph.szoveg }}</p>
            <hr>
        </div>
    </main>
</template>
<script>
import { trigger } from '@vue/reactivity';
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
        axios.get(this.$store.getters.baseURL+"/csaladtagok/ID/"+this.nodeid, {headers: {"authorization": "JWT "+this.$store.getters.Token}})
        .then(res=>{
            this.node=res.data[0]
            axios.get(this.$store.getters.baseURL+"/eletut/csaladtagID/"+this.nodeid, {headers: {"authorization": "JWT "+this.$store.getters.Token}})
            .then(res=>{
                this.paragraphs=res.data;
                this.paragraphs.forEach(element => {
                    element.edit=false;
                });
            })
        })
        
    },
    methods:{
        Torles(paragraph){
            axios.delete(this.$store.getters.baseURL+"/eletut/ID/"+Id, {headers: {"authorization": "JWT "+this.$store.getters.Token}})
            .then(res =>{
                this.paragraphs.splice(this.paragraphs.findIndex(x=>x.ID == paragraph.ID),1)
            })
            console.log(this.paragraphs)
        },
        Szerekesztes(paragraph){
            paragraph.edit=true;
        }
    }

}
</script>
<style>
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