<template>
<div class="theme_bg m-0" id="container">    
    <button class="btn btn-primary visszagomb rounded-circle btn-dark" @click="Vissza()"><i class="bi bi-arrow-left"></i></button>
    <header class="row p-3">
        
        <img class="col-xs-12 col-lg-4 col-md-3  kep m-3 p-0" :src="SetProfilePic()">
        <h2 class="col-xs-4 col-lg-6 col-md-5  d-flex justify-content-center flex-column familytree_text">{{ node.vezeteknev+" "+node.keresztnev }}</h2>
        <transition name="fade">
            <div class="col-xs-4 col-lg-2 col-md-4  d-flex justify-content-end flex-column"  v-if="!vendeg"><button class="btn btn-dark" @click="UjParagrafus()" > Új paragrafus írása </button></div>
        </transition>
    </header>
    <hr>
    <main class="w-75">
            <div v-for="paragraph, index in paragraphs">
            <div class="d-flex flex-row justify-content-between align-items-center">
                <div class="col-6 col-md-5 col-lg-4">
                    <input v-if="paragraph.edit" type="text" class="form-control familytree_input" placeholder="Cím" v-model="paragraph.cim">
                    <h3 class="text-wrap text-break familytree_text" v-else >{{ paragraph.cim }}</h3>
                </div>
                    <div class="d-flex flex-row justify-content-between ">
                        <button v-if="paragraph.edit && !vendeg" class="m-1 m-lg-2 m-sm-1 btn btn-warning btn-md orange-bgc" @click="SzerekesztesVeglegesites(paragraph)"><i class="bi bi-check-lg"></i></button>
                        <button v-if="!paragraph.edit && !vendeg" class="m-1 m-lg-2 m-sm-1 btn btn-secondary btn-md orange-bgc" @click="Szerekesztes(paragraph)"><i class="bi bi-pencil"></i></button>
                        <button v-if="!vendeg" class="m-1 m-lg-2 m-sm-1 btn btn-secondary btn-md" @click="ParagrafusAtadas(paragraph)" data-bs-toggle="modal" data-bs-target="#confirmModal"><i class="bi bi-trash"></i></button>
                    </div>
            </div>
            <div class="p-2 m-2">
                <textarea v-if="paragraph.edit" class="form-control familytree_input" v-model="paragraph.szoveg" aria-label="With textarea"></textarea>
                <p class="mb-2 text-wrap text-break familytree_text" v-if="!paragraph.edit && paragraph.szoveg != null" v-for="par in paragraph.szoveg.split('\n')">{{ par }}<br></p>
            </div>
            <hr id="ujszoveg">
        </div>
        <div ref="szoveghezgorgetes"> </div>
        <Galery :nodeId="nodeid" vendeg:vendeg ref="gallery"/>


        <!-- Confrim Modal -->
    <div class="modal fade" id="confirmModal">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content theme_bg">
          <div class="modal-header orange-bgc">
            <h5 class="modal-title">Családfa törlése</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body theme_bg">
            <h5 class="m-3 text-center familytree_text">
              Biztosan törölni kívánja a paragrafust?
            </h5>
            <div class="d-flex justify-content-around">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Mégse</button>
              <button type="button" class="btn btn-primary orange-bgc" data-bs-dismiss="modal" @click="Torles(actparagraph)">Törlés</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    </main>
    <transition name="fade">
<div id="pagetop" class="fixed right-0 bottom-0" v-show="scY > 300">
  <button class="btn btn-primary rounded-circle btn-dark float-right" @click="toTop"> <i class="bi bi-arrow-up-circle"></i> </button>
</div>
</transition>
   

  
</div>
</template>
<script>
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
            vendeg:true,
            ready: false,
            sidebarStyle:{},
            darkmode:0,
            scTimer: 0,
            scY: 0,
            actparagraph:{},
        }
    },
    mounted() {
      window.addEventListener('scroll', this.handleScroll);
    },
    beforeMount(){
        axios.get(this.$store.getters.baseURL+"/csaladtagok/ID/"+this.nodeid, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
        .then(res=>{
            //ha nem létező családtag
            if (res.data.length < 1) {
                router.push('/');
            }
            else{
                this.node=res.data[0]
                this.$store.commit('SetMembers', [this.node]);
                axios.post(this.$store.getters.baseURL+ "/user/data", {token :'JWT ' + JSON.parse(sessionStorage.getItem('csaladomemleke'))})
                .then(sajat =>{
                    axios.get(this.$store.getters.baseURL + "/csaladfak/ID/" + this.node.csaladfaID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                    .then(csaladfa=>{
                        axios.get(this.$store.getters.baseURL + "/beallitasok/csaladfaID/" + this.node.csaladfaID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                        .then(publik =>{
                            if (csaladfa.data[0].felhasznaloID == sajat.data.ID) {
                                //saját családfa: megtekinthető és szerkeszthető
                                this.vendeg = false;
                            }
                            else if (publik.data[0].publikus == 0 && sajat.data.jogosultsag != 2){
                                //nem saját családfa, nem publikus: nem megtekinthető
                                router.push('/');
                            }
                            axios.get(this.$store.getters.baseURL+"/eletut/csaladtagID/"+this.nodeid, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                            .then(res=>{
                                this.paragraphs=res.data;
                                this.paragraphs.forEach(element => {
                                    element.edit=false;
                                });
                                this.SetMode(publik.data[0].darkmode);
                                this.ready = true;
                            })
                        })
                    })
                })
            }
        })
    },
    methods:{
        ParagrafusAtadas(paragraph){
            this.actparagraph=paragraph
        },
        SetMode(mode){
            this.darkmode=mode;
            if (mode == 1) {
                this.sidebarStyle={
                    bgcolor:"rgb(43, 43, 43)",
                    color:"white",
                    inputbgcolor:"rgb(51,51,51)",
                }
            }else if(mode == 0) {
                this.sidebarStyle={
                    bgcolor:"rgb(226, 226, 226)",
                    color:"black",
                    inputbgcolor:"white",
                }
            }
        },
        handleScroll: function () {
        if (this.scTimer) return;
        this.scTimer = setTimeout(() => {
          this.scY = window.scrollY;
          clearTimeout(this.scTimer);
          this.scTimer = 0;
        }, 100);
      },
      toTop: function () {
        window.scrollTo({
          top: 0,
          behavior: "smooth"
        });
      },
      toBottom(){
      this.$refs['szoveghezgorgetes'].scrollIntoView({behavior: "smooth"})
    },
        SetProfilePic(){
            if (!this.ready || this.$store.getters.Members[0].profilkep==null) {
                let nopicnev=""
                if (this.darkmode==1) {
                    nopicnev="nopicdarkmode"
                }else{
                    nopicnev="nopic"

                }
                return `${this.$store.getters.baseURL}/assets/${nopicnev}.png`
            }else{
                return this.$store.getters.Members[0].profilkep
            }
        },
        Torles(paragraph){
            //showdialog
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
            this.toBottom();
            if (this.paragraphs.find(x => x.edit) == null) { 
                
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
    },
}

</script>

<style>
body, html{
    overflow: visible !important;
    scroll-behavior: smooth;
}

a{
    text-decoration: none;
    color: white;
    display: block;
}

.theme_bg{
    background-color: v-bind('sidebarStyle.bgcolor');
}
.familytree_text{
    color: v-bind('sidebarStyle.color') !important;
}
.familytree_input{
    background-color: v-bind('sidebarStyle.inputbgcolor');
    color: v-bind('sidebarStyle.color');
}
.familytree_input::placeholder{
    color: v-bind('sidebarStyle.color') !important;
    opacity: 0.5;
}

.familytree_input:focus{
    background-color: v-bind('sidebarStyle.inputbgcolor');
    color: v-bind('sidebarStyle.color');
}

/* Scrollbar style */
::-webkit-scrollbar {
    width: 10px;
}

::-webkit-scrollbar-track {
    background: v-bind('sidebarStyle.bgcolor');
}

::-webkit-scrollbar-thumb {
    background: rgb(105, 105, 105);
    border-radius: 10px;
}

::-webkit-scrollbar-thumb:hover {
    background: #555;
}

</style>

<style scoped>

.orange-bgc{
    background-color: #ff7112;
    border-color: #8b3800;
    color: white;
}

#container{
    min-height: 100vh;
}
hr{
    color: v-bind('sidebarStyle.color');
}
.kep{
    width: 18vw;
    height: 18vw;
    border-radius: 50%;
    border: 2px solid v-bind('sidebarStyle.color');
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
.modal{
    padding-right: 0 !important;
}


</style>