<template>
    <div id="app">
        <qr_modal v-if="$store.getters.QR_Modal.visible" :url="$store.getters.Domain+'/eletut/'+$store.getters.QR_Modal.node.ID"/>

        <div v-if="!vendeg">
            <i class="bi bi-menu-up btn btn-dark btn-lg rounded-circle m-3" id="menuBtn" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling"></i>
            <FamilyMenu :csaladfaID="csaladfaID" />
        </div>
        <FamilyTree ref="tree"/>
    </div>
</template>

<script>
import axios from 'axios';
import FamilyTree from '../components/family/FamilyTree.vue';
import FamilyMenu from '../components/family/familymenu/familymenu.vue';
import router from '../router';
import qr_modal from '../components/family/qr_modal.vue';

export default{
    props:{
        csaladfaID:String
    },
    components:{
        FamilyMenu,
        FamilyTree,
        qr_modal,
        axios
    },
    data(){
        return{
            vendeg:true,
            sidebarStyle:{}
        }
    },
    created(){
        axios.post(this.$store.getters.baseURL+ "/user/data", {token :'JWT ' + JSON.parse(sessionStorage.getItem('csaladomemleke'))})
        .then(sajat =>{
            axios.get(this.$store.getters.baseURL + "/csaladfak/ID/" + this.csaladfaID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
            .then(csaladfa=>{
                axios.get(this.$store.getters.baseURL + "/beallitasok/csaladfaID/" + this.csaladfaID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                .then(publik =>{
                    this.$store.commit('SetCsaladfaID', this.csaladfaID);
                    this.$store.commit('SetNev', sajat.data.Nev);
                    if (csaladfa.data[0].felhasznaloID == sajat.data.ID) {
                        //saját családfa: megtekinthető és szerkeszthető
                        this.vendeg = false;
                        this.GetMembers(true);
                    }
                    else if (publik.data[0].publikus == 1  || sajat.data.jogosultsag == 2){
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
            axios.get(this.$store.getters.baseURL + "/beallitasok/csaladfaID/" + this.$store.getters.CsaladfaID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
            .then(res => {
                let settings = res.data[0];
                axios.get(this.$store.getters.baseURL + "/csaladfak/ID/" + this.$store.getters.CsaladfaID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                .then(results => {
                    settings.Nev = results.data[0].Nev
                    this.$store.commit('LoadSettings', settings);
                    axios.get(this.$store.getters.baseURL + "/csaladtagok/csaladfaID/" + this.$store.getters.CsaladfaID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                    .then(res => {
                        this.$store.commit('SetMembers', res.data);
                        try {
                            this.$refs.tree.Rajzol(sajat, settings);
                        } catch (error) {}
                    })
                })
            })

        }
    },
    watch:{
        '$route.params.csaladfaID': {
            handler: function(csaladfaID) {
                this.$store.commit('SetCsaladfaID', csaladfaID)
                this.GetMembers(!this.vendeg);
            },
            deep: true,
        },
        '$store.getters.Settings' :{
            handler: function(Settings) {
                  if (this.$store.getters.Settings.darkmode) {
                    this.sidebarStyle={
                        bgcolor:"rgb(43, 43, 43)",
                        color:"white",
                        inputbgcolor:"rgb(51,51,51)",
                    }
                }else{
                    this.sidebarStyle={
                        bgcolor:"rgb(226, 226, 226)",
                        color:"black",
                        inputbgcolor:"white",
                        }
                }
            },
        deep: true,
      }
    }
}


</script>

<style>

/* Dark / Light mode binding */
  .modalheader{
    background-color: rgb(255,113,18) !important;
    color: white;
  }
  .familytreetext{
    color: v-bind('sidebarStyle.color') !important;
  }
  .familytreeinput{
    background-color: v-bind('sidebarStyle.inputbgcolor');
    color: v-bind('sidebarStyle.color');
  }
  .familytreeinput::placeholder{
    color: v-bind('sidebarStyle.color') !important;
    opacity: 0.5;
  }

  .familytreeinput:focus{
    background-color: v-bind('sidebarStyle.inputbgcolor');
    color: v-bind('sidebarStyle.color');
  }
  .familytreeinput:disabled{
    background-color: v-bind('sidebarStyle.inputbgcolor');
    color: v-bind('sidebarStyle.color');
  }
  .themebg{
    background-color: v-bind('sidebarStyle.bgcolor');
  }

  .offcanvas{
    z-index: 200 !important;
    color: v-bind('sidebarStyle.color') !important;
  }
  #maindiv *{
    color: v-bind('sidebarStyle.color');
  }
  #offcanvasScrolling{
    background-color: v-bind('sidebarStyle.bgcolor');
    text-align: center;
  }

  /* ----------------------------------------- */

  #maindiv div a{
    padding-bottom: 5px;
    transition: 0.5s;
    border-bottom: v-bind('sidebarStyle.bgcolor') 2px solid;
  }
  #maindiv div a:hover{
    padding-right: clamp(5px, 50px, 5vw);
    padding-left: clamp(5px, 50px, 5vw);
    border-bottom: #ff7112 2px solid;
  }


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
    overflow:hidden;
    font-family: Helvetica;
}

#tree {
    width: 100%;
    height: 100%;
}

.bft-input {
    max-width: 90vw !important;
}

#bft-avatar img{
    object-fit: cover !important;
}

.bft-edit-form{
    z-index: 30 !important;
}

.modal-backdrop{
  z-index: 40 !important;
}

/* Scrollbar style */
::-webkit-scrollbar {
    width: 10px;
}

::-webkit-scrollbar-track {
    background: v-bind('sidebarStyle.bgcolor');
    border-radius: 10px;
}

::-webkit-scrollbar-thumb {
    background: rgb(105, 105, 105);
    border-radius: 10px;
}

::-webkit-scrollbar-thumb:hover {
    background: #555;
}
</style>