<template>
  <h1>
    Galéria
  </h1>
  <input type="file" multiple class="form-control" @change="SelectImages" accept="image/*">
  <div class="text-center">
    <img :src="preview"  class="m-2 previews " alt="thumbnail" v-for="preview in previews">
  </div>
  <div v-if="previews.length!=0" class="text-center">
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
        <img :src="$store.getters.baseURL + '/img/' + picture.Nev" class="d-block m-auto pictures" alt="kép">
      </a>
      <div class="carousel-caption d-none d-md-block">
        <button class="btn btn-danger m-3" @click="Remove(picture)"><i class="bi bi-trash"></i></button>
        <button class="btn btn-success m-3" @click="Download(picture)"><i class="bi bi-download"></i></button>
        <button class="btn btn-secondary m-3" @click="SetProfile(picture)"><i class="bi bi-person-bounding-box"></i></button>
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
h1{
  text-align: center;
  font-family: "Brush Script MT", cursive;
  font-size: 500%;
  margin-bottom: 3vw;
}
.carousel-control-prev, .carousel-control-next{
  background-color: rgba(0, 0, 0, 0.2);
}
.pictures{
  object-fit: scale-down;
}
.h-60vh{
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
    }
  },
  created(){
    axios.get(this.$store.getters.baseURL+"/kepek/csaladtagID/"+this.nodeId, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
        .then(res=>{
          this.pictures=res.data
        })
  },
  methods:{
    SelectImages(e){
      this.previews = [];
      for (let i = 0; i < e.target.files.length; i++) {
        if (e.target.files[i].type.includes("image")) {
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
      axios.delete(this.$store.getters.baseURL + "/fileDelete/kepek/" + picture.ID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
      .then(res =>{
        axios.delete(this.$store.getters.baseURL + "/kepek/ID/" + picture.ID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
        .then(res=>{
          this.pictures.splice(this.pictures.findIndex(x => x.ID == picture.ID), 1);
        })
      })
    },
    SetProfile(picture){
      let node = this.$store.getters.Members[0]
      node.profilkep = picture.Nev
      this.$store.commit('UpdateNode', node);
    },
  }
}
</script>
