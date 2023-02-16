<template>
    <FamilyMenu />
    <div id="app">
        <FamilyTree v-if="Csaladfa" ref="tree" />
        <Settings v-if="Beallitasok"/>
        <Contacts v-if="Elerhetosegek"/>
        <UserManagment v-if="Felhasznalokezeles"/>
    </div>
</template>

<script>
    import axios from 'axios';
    import FamilyTree from '../components/family/FamilyTree.vue';
    import FamilyMenu from '../components/family/familymenu.vue';
    import Settings from '../components/family/settings.vue';
    import Contacts from '../components/family/contacts.vue';
    import UserManagment from '../components/family/usermanagment.vue'

    export default{
        components:{
    FamilyMenu,
    FamilyTree,
    Settings,
    Contacts,
    UserManagment
},
data(){
      return {
        Csaladfa: true,
        Beallitasok: false,
        Elerhetosegek: false,
        Felhasznalokezeles: false
      }
    },
    methods:{
        CurrentPage(szam){
        if (szam == 4) {
            this.Elerhetosegek = true
            this.Csaladfa = false,
            this.Beallitasok = false,
            this.Felhasznalokezeles = false
        }
        else if(szam == 3){
            this.Beallitasok = false, 
            this.Csaladfa = false,
            this.Elerhetosegek = false,
            this.Felhasznalokezeles = true
        }
        else if(szam == 2){
            this.Beallitasok = true, 
            this.Csaladfa = false,
            this.Elerhetosegek = false,
            this.Felhasznalokezeles = false
        }
        else if(szam == 1){
            this.Csaladfa= true,
            this.Beallitasok = false, 
            this.Elerhetosegek = false,
            this.Felhasznalokezeles = false
        }
      }
    },


        created(){
            //családfa betöltése------------------------------------------------------------------------------------>
            axios.get(this.$store.getters.baseURL + "/csaladfak/felhasznaloID/" + this.$store.getters.loggedUser.ID)
            .then(res => {
                let user = this.$store.getters.loggedUser;
                this.$store.commit('SetUser', Object.assign(user, {csaladfak: res.data}))
                let fa = this.$store.getters.loggedUser.csaladfak.find(x => x.alapertelmezett == 0);
                axios.get(this.$store.getters.baseURL + "/csaladtagok/csaladfaID/" + fa.ID)
                .then(res => {
                    this.$store.commit('SetMembers', res.data);
                    this.$refs.tree.Rajzol();
                })
            })
            //------------------------------------------------------------------------------------------------------>
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