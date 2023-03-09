<template>
    <button class="btn btn-primary visszagomb rounded-circle btn-dark" @click="Vissza()"><i class="bi bi-arrow-left"></i></button>
    <header class="row p-3">
        <img class="col-xs-12 col-lg-4 col-md-3  kep m-3 p-0" :src="$store.getters.baseURL + '/img/' + this.$store.getters.Members[0].profilkep" alt="felhasznalo profilkep">
        <h2 class="col-xs-4 col-lg-6 col-md-5  d-flex justify-content-center flex-column">{{ node.vezeteknev+" "+node.keresztnev }}</h2>
        <div class="col-xs-4 col-lg-2 col-md-4  d-flex justify-content-end flex-column"><button class="btn btn-dark m-3" @click="UjParagrafus()">Új paragrafus írása</button></div>
    </header>
    <hr>
    <main class="w-75">
        <p>
            <div class="m-3" v-for="paragraph, index in paragraphs">
            <div class="row">
                <div class="col-6 col-md-5 col-lg-4">
                    <input v-if="paragraph.edit" type="text" class="form-control" placeholder="Cím" v-model="paragraph.cim">
                    <h3 class="" v-else >{{ paragraph.cim }}</h3>
                </div>
                <div class="col-6 col-md-7 col-lg-8 d-flex flex-row-reverse">
                    <div>
                        <button v-if="paragraph.edit" class="m-1 m-lg-2 m-sm-1 btn btn-warning" @click="SzerekesztesVeglegesites(paragraph)"><i class="bi bi-check-lg"></i></button>
                        <button v-else class="m-1 m-lg-2 m-sm-1 btn btn-warning" @click="Szerekesztes(paragraph)"><i class="bi bi-pencil"></i></button>
                        <button class="m-1 m-lg-2 m-sm-1 btn btn-danger" @click="Torles(paragraph)"><i class="bi bi-trash"></i></button>
                    </div>
                </div>
            </div>
            <div class="p-3 m-3">
                <textarea v-if="paragraph.edit" class="form-control" v-model="paragraph.szoveg" aria-label="With textarea"></textarea>
                <p v-else>{{ paragraph.szoveg }}</p>
            </div>
            <hr>
        </div>
        <Galery :nodeId="nodeid" />

    </p>
    </main>
</template>
<script>
import { trigger } from '@vue/reactivity';
import axios from 'axios';
import router from '../router';
import Galery from '../components/galery.vue';


export default{
    props:{
        nodeid:String

    },
    components:{
        Galery
    },
    data(){
        return{
            node:{},
            paragraphs:[],
        }
    },
    created(){
        axios.get(this.$store.getters.baseURL+"/csaladtagok/ID/"+this.nodeid, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
        .then(res=>{
            this.node=res.data[0]
            this.$store.commit('SetMembers', [this.node]);
            axios.get(this.$store.getters.baseURL+"/eletut/csaladtagID/"+this.nodeid, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
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
            axios.delete(this.$store.getters.baseURL+"/eletut/ID/"+paragraph.ID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
            .then(res =>{
                this.paragraphs.splice(this.paragraphs.findIndex(x=>x.ID == paragraph.ID),1)
            })
        },
        Szerekesztes(paragraph){
            paragraph.edit=true;

        },
        SzerekesztesVeglegesites(paragraph){
            let updated={
                cim:paragraph.cim,
                szoveg:paragraph.szoveg
            }
            axios.patch(this.$store.getters.baseURL+"/eletut/"+paragraph.ID, updated, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
            .then(res =>{
                paragraph.edit=false;
            })
        },
        Vissza(){
            axios.get(this.$store.getters.baseURL+"/csaladtagok/ID/"+this.nodeid, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
            .then(res =>{
                router.push("/csalad/"+res.data[0].csaladfaID)
            })
        },
        UjParagrafus(){
            //console.log(this.$store.getters);
            let empty={
                csaladtagID:this.nodeid,
                cim:"",
                szoveg:""
            }
            axios.post(this.$store.getters.baseURL+"/eletut", empty, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
            .then(res => {
                empty.ID=res.data.insertId
                empty.edit=true
                this.paragraphs.push(empty)
            })
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
    text-align: justify;
}
main{
    margin-left: auto;
    margin-right: auto;
}
.row{
    margin-left: 0px;
    margin-right: 0px;
}


</style>