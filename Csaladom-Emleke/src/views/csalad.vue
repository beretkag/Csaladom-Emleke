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

export default{
    components:{
        FamilyMenu,
        FamilyTree,
        axios
    },
    created(){

        axios.post(this.$store.getters.baseURL+ "/user/data", {token :'JWT ' + this.$store.getters.Token})
        .then(res =>{
            //családfa betöltése------------------------------------------------------------------------------------>
            //------------------------------------------------------------------------------------------------------>
            axios.get(this.$store.getters.baseURL + "/csaladfak/felhasznaloID/" + res.data.ID, {headers: {"authorization": "JWT "+this.$store.getters.Token}})
            .then(res => {
                let idx = res.data.find(x => x.alapertelmezett == 0).ID
                axios.get(this.$store.getters.baseURL + "/csaladtagok/csaladfaID/" + idx, {headers: {"authorization": "JWT "+this.$store.getters.Token}})
                .then(res => {
                    this.$store.commit('SetMembers', res.data);
                    this.$refs.tree.Rajzol();
                })
            })
        })
    },
            
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