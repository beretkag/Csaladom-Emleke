<template>
    <FamilyMenu />
    <div id="app">
        <FamilyTree ref="tree"/>
    </div>
</template>

<script>
    import axios from 'axios';
    import FamilyTree from '../components/family/FamilyTree.vue';
    import FamilyMenu from '../components/family/familymenu.vue';
    import Settings from '../components/family/settings.vue';
    import Contacts from '../components/family/contacts.vue';

    export default{
        components:{
    FamilyTree,
    FamilyMenu,
    Settings,
    Contacts
},

        created(){
            //családfa betöltése
            axios.get(this.$store.getters.baseURL + "/csaladfak/felhasznaloID/" + this.$store.getters.loggedUser.ID)
            .then(res => {
                this.$store.commit('SetUser', Object.assign(this.$store.getters.loggedUser, {csaladfak: res.data}))
                let fa = this.$store.getters.loggedUser.csaladfak.find(x => x.alapertelmezett == 0);
                axios.get(this.$store.getters.baseURL + "/csaladtagok/csaladfaID/" + fa.ID)
                .then(res => {
                    this.$store.commit('SetMembers', res.data);
                    this.$refs.tree.Rajzol();
                })
            })
        },
        
    }
</script>

<style>
#app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    height: 80vh
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