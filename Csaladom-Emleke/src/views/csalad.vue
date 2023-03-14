<template>
    <div id="app">
        <div v-if="!vendeg">
            <i class="bi bi-menu-up btn btn-dark btn-lg rounded-circle m-3" id="menuBtn" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling"></i>
            <FamilyMenu />
        </div>
        <FamilyTree ref="tree" />
    </div>
</template>

<script>
import axios from 'axios';
import FamilyTree from '../components/family/FamilyTree.vue';
import FamilyMenu from '../components/family/familymenu/familymenu.vue';
import router from '../router';

export default{
    props:{
        csaladfaID:String
    },
    components:{
        FamilyMenu,
        FamilyTree,
        axios
    },
    data(){
        return{
            vendeg:true
        }
    },
    created(){
        axios.post(this.$store.getters.baseURL+ "/user/data", {token :'JWT ' + JSON.parse(sessionStorage.getItem('csaladomemleke'))})
        .then(sajat =>{
            axios.get(this.$store.getters.baseURL + "/csaladfak/ID/" + this.csaladfaID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
            .then(csaladfa=>{
                axios.get(this.$store.getters.baseURL + "/beallitasok/csaladfaID/" + this.csaladfaID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                .then(publik =>{
                    if (csaladfa.data[0].felhasznaloID == sajat.data.ID) {
                        //saját családfa: megtekinthető és szerkeszthető
                        this.vendeg = false;
                        this.GetMembers(true);
                    }
                    else if (publik.data[0].publikus == 1){
                        //nem saját családfa, publikus: csak megtekinthető
                        this.GetMembers(false);
                    }
                    else {
                        //nem saját családfa, nem publikus: nem megtekinthető
                        router.push('/');
                    }
                })

            })
        })
    },
    methods:{
        GetMembers(sajat){
            //családfa betöltése
            axios.get(this.$store.getters.baseURL + "/csaladtagok/csaladfaID/" + this.csaladfaID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
            .then(res => {
                this.$store.commit('SetMembers', res.data);
                this.$refs.tree.Rajzol(sajat);
            })
        }
    }
            
}
</script>

<style scoped>


@media all and (max-width:1000px) {
    #menuBtn{
        position: absolute;
        bottom: 5px;
        left: 5px;
        z-index: 50;
    }
}

@media all and (min-width:1001px) {
    #menuBtn{
        position: absolute;
        top: 5px;
        left: 5px;
        z-index: 50;
    }
}

#menuBtn:hover{
   border: 1px solid #ff7112;
}
#app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    color: #2c3e50;
    height: 100vh;
}

html, body {
    width: 100%;
    height: 100%;
    padding: 0;
    margin: 0;
    overflow: hidden;
    font-family: Helvetica;
}

#tree {
    width: 100%;
    height: 100%;
}
</style>