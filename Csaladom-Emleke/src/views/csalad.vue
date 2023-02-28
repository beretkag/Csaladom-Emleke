<template>
    <FamilyMenu />
    <div id="app">
        <i class="bi bi-menu-up btn btn-dark btn-lg rounded-circle m-3" id="menuBtn" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling"></i>
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
    created(){
        axios.post(this.$store.getters.baseURL+ "/user/data", {token :'JWT ' + JSON.parse(sessionStorage.getItem('csaladomemleke'))})
        .then(res =>{
            if (res.data.jogosultsag == 0) {
                axios.get(this.$store.getters.baseURL + "/csaladfak/ID/" + this.csaladfaID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                .then(results=>{
                    console.log(results.data.publikus)
                    if (results.data.publikus) {
                        //nem saját családfa: csak megtekinthető
                        this.GetMembers(false);
                    }
                    else {
                        router.push('/');
                    }
                })
            }
            else if (res.data.jogosultsag == 1){
                axios.get(this.$store.getters.baseURL + "/csaladfak/ID/" + this.csaladfaID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                .then(results=>{
                    if (results.data[0].felhasznaloID == res.data.ID) {
                        //saját családfa: megtekinthető és szerkeszthető
                        this.GetMembers(true);
                    }
                })
            }
            
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

#menuBtn{
    position: absolute;
    top: 5px;
    left: 5px;
    z-index: 999;
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