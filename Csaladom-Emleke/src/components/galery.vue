<template>
  <h1>
    Galéria
  </h1>
  <input v-if="!vendeg" type="file" multiple class="form-control" @change="SelectImages" accept="image/*">
  <div class="text-center">
    <img :src="preview"  class="m-2 previews " alt="thumbnail" v-for="preview in previews">
  </div>
  <div v-if="previews.length!=0 && !vendeg" class="text-center">
    <button  class="btn btn-primary ms-auto" @click="Upload()">Kép feltöltése</button>
  </div>


<!-- Gallery -->
<div id="carouselExampleCaptions" class="carousel slide m-auto">
  <div class="carousel-indicators">
    <button v-for="picture, index in pictures" type="button" data-bs-target="#carouselExampleCaptions" :aria-current="{'true' : index==0}" :data-bs-slide-to="index" :class="{'active' : index==0}"></button>
  </div>
  <div class="carousel-inner">
    <div v-for="picture, index in pictures" class="carousel-item h-60vh" :class="{'active' : index==0}">
      <a :href="$store.getters.baseURL + '/img/' + picture.Nev" class="h-60vh d-flex align-items-center" target="_blank">
        <img :src="$store.getters.baseURL + '/img/' + picture.Nev" class="m-auto pictures" alt="kép">
      </a>
      <div class="carousel-caption p-0 d-flex align-items-end justify-content-center">
        <button class="btn btn-sm btn-danger m-2 position-relative bottom-0" data-bs-target="#carouselExampleCaptions" :data-bs-slide="index+1 == pictures.length ? 'next' : null" @click="Remove(picture)"
          v-if="$store.getters.baseURL + '/img/' + picture.Nev != this.$store.getters.Members[0].profilkep && !vendeg">
          <i class="bi bi-trash"></i>
        </button>
        <button class="btn btn-sm btn-success m-2 position-relative bottom-0" @click="Download(picture)">
          <i class="bi bi-download"></i>
        </button>
        <button class="btn btn-sm btn-secondary m-2 position-relative bottom-0" @click="SetProfile(picture)" v-if="!vendeg">
          <i class="bi bi-x-lg" v-if="$store.getters.baseURL + '/img/' + picture.Nev == this.$store.getters.Members[0].profilkep"></i>
          <i class="bi bi-person-bounding-box" v-else></i>
        </button>
      </div>
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

</template>
<style scoped>
.carousel-caption .btn{
  z-index: 999;
}

h1{
  text-align: center;
  font-family: "Brush Script MT", cursive;
  font-size: 500%;
  margin-bottom: 3vw;
}
.carousel-control-prev, .carousel-control-next{
  background-color: rgba(0, 0, 0, 0.2);
}
.h-60vh{
  height: 40vw;
}

.pictures{
  /* object-fit: scale-down; */
  width: unset !important;
  height: 40vw;
}
.previews{
  height: 8vh;
  
}
input{
  width: 150px !important;
  margin:0 auto 10px auto ;
}


</style>
<script>
import axios from 'axios';


export default{
  props:{
        nodeId:String

    },
  data(){
    return{
      images: [],
      previews: [],
      pictures:[],
      csaladfaID:"",
      vendeg:true,
    }
  },
  created(){
    axios.get(this.$store.getters.baseURL+"/kepek/csaladtagID/" + this.nodeId, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
        .then(res => {
          this.pictures = res.data
          axios.get(this.$store.getters.baseURL + "/csaladtagok/ID/" + this.nodeId, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
          .then(res => {
            this.csaladfaID = res.data[0].csaladfaID;
          })
        })
  },
  methods:{
    SelectImages(e){
      this.previews = [];
      this.images = [];
      for (let i = 0; i < e.target.files.length; i++) {
        if (e.target.files[i].type.includes("image") && e.target.files[i].size < 5242881) {
          this.images.push(e.target.files[i])
          this.AddPreview(e.target.files[i])
        }
      }
      
    },

    AddPreview(file){
      const reader = new FileReader();
      reader.addEventListener(
        "load",
        () => {
          this.previews.push(reader.result);
        },
        false
      );
  
      if (file) {
        reader.readAsDataURL(file);
      }
    },
    Download(picture){
      var url = '../API/Uploads/' + picture.Nev
      var tmp = document.createElement('A');
      tmp.href = url;
      tmp.download = picture.Nev;
      tmp.click();
    },
    Upload(){
      let data = new FormData();
      for (let i = 0; i < this.images.length; i++) {
        data.append('files', this.images[i]); 
      }
      axios.post(this.$store.getters.baseURL + "/fileUpload", data, {
        headers: {
          "authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke')),
          'Content-Type': 'multipart/form-data'
        }
      })
      .then(res=>{
        this.images = [],
        this.previews = []
        for (let i = 0; i < res.data.length; i++) {
          let data = {
            csaladtagID: this.nodeId,
            csaladfaID: this.csaladfaID,
            Nev: res.data[i].filename
          }
          axios.post(this.$store.getters.baseURL+"/kepek", data, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
          .then(res=>{
            data.ID = res.data.insertId;
            this.pictures.push(data);
          })
        }
      })
    },
    Remove(picture){
      axios.delete(this.$store.getters.baseURL + "/fileDelete/kepek/ID/" + picture.ID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
      .then(res =>{
        axios.delete(this.$store.getters.baseURL + "/kepek/ID/" + picture.ID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
        .then(res=>{
          this.pictures.splice(this.pictures.findIndex(x => x.ID == picture.ID), 1);
          if (this.$store.getters.baseURL + '/img/' + picture.Nev == this.$store.getters.Members[0].profilkep) {
            let data ={
              profilkep: ""
            }
            axios.patch(this.$store.getters.baseURL + "/csaladtagok/" + this.nodeId, data, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
            .then(res => {
              let node = this.$store.getters.Members[0]
              node.profilkep = null;
              this.$store.commit('UpdateNode', node);
            })
          }
        })
      })
    },
    SetProfile(picture){
      let data={};
      if (this.$store.getters.baseURL + '/img/' + picture.Nev == this.$store.getters.Members[0].profilkep) {
        data.profilkep = "";
      } else {
        data.profilkep= picture.Nev
      }
      axios.patch(this.$store.getters.baseURL + "/csaladtagok/" + this.nodeId, data, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
      .then(res => {
        let node = this.$store.getters.Members[0]
        node.profilkep = data.profilkep != "" ? this.$store.getters.baseURL + "/img/" + data.profilkep : null;
        this.$store.commit('UpdateNode', node);
      })
    },
  }
}
</script>
