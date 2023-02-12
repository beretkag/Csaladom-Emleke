<template>
    <div id="app">
        <FamilyTree />
    </div>
</template>

<script>
    import axios from 'axios';
    import FamilyTree from '../components/family/FamilyTree.vue';

    export default{
        components:{
            FamilyTree
        },
        created(){
            //családfa betöltése
            axios.get(this.$store.getters.baseURL + "/csaladfak/felhasznaloID/" + this.$store.getters.loggedUser.ID)
            .then(res => {
                this.$store.commit('SetUser', Object.assign(this.$store.getters.loggedUser, {csaladfak: res.data}))
                let fa = this.$store.getters.loggedUser.csaladfak.find(x => x.alapertelmezett == 0);
                axios.get(this.$store.getters.baseURL + "/csaladtagok/csaladfaID/" + fa.ID)
                .then(res => {
                    console.log(res.data);
                    this.$store.commit('SetMembers', res.data);
                })
            })
        },
        methods:{
            
        }
        
    }
</script>

<style>
#app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    height: 95vh;
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